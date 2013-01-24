// os-insight.cpp: определяет точку входа для консольного приложения.
//

#ifdef _MSC_VER
#include "win32/stdafx.h"
#include <Windows.h>
#pragma comment (lib, "Ws2_32.lib")
#endif

#include "os/objectscript.h"
#include "fcgi-2.4.1/include/fcgi_stdio.h"
#include "MPFDParser-1.0/Parser.h"
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>

#ifndef _MSC_VER
#include <pthread.h>
#endif

using namespace ObjectScript;

class FCGX_OS: public OS
{
protected:

	FCGX_Request * request;
	int shutdown_funcs_id;
	bool header_sent;

	virtual ~FCGX_OS()
	{
	}

public:

	FCGX_OS()
	{
		request = NULL;
		header_sent = false;
	}

	EFileUseType checkFileUsage(const String& sourcecode_filename, const String& compiled_filename)
	{
		struct stat sourcecode_st, compiled_st;
		stat(sourcecode_filename, &sourcecode_st);
		stat(compiled_filename, &compiled_st);
		if(sourcecode_st.st_mtime >= compiled_st.st_mtime){
			return COMPILE_SOURCECODE_FILE;
		}
		return LOAD_COMPILED_FILE;
	}

	void initPreScript()
	{
#if defined _MSC_VER && defined OS_DEBUG
		setSetting(OS_SETTING_CREATE_DEBUG_EVAL_OPCODES, false);
		setSetting(OS_SETTING_CREATE_DEBUG_OPCODES, true);
#else
		setSetting(OS_SETTING_CREATE_DEBUG_EVAL_OPCODES, false);
		setSetting(OS_SETTING_CREATE_DEBUG_OPCODES, false);
#endif
		setSetting(OS_SETTING_CREATE_DEBUG_INFO, true);
		setSetting(OS_SETTING_CREATE_COMPILED_FILE, true);
		OS::initPreScript();
	}

	void initEnv(const char * var_name, char ** envp)
	{
		newObject();
		for(; *envp; envp++){
			const char * value = *envp;
			const char * split = strchr(value, '=');
			OS_ASSERT(split);
			if(split){
				pushStackValue(-1);
				pushString(value, (int)(split - value));
				pushString(split + 1);
				setProperty();
			}
		}
		setGlobal(var_name);
	}

	void echo(const OS_CHAR * str)
	{
		if(!header_sent){
			header_sent = true;
			FCGX_PutS("Content-type: text/html\r\n\r\n", request->out);
		}
		FCGX_PutS(str, request->out);
	}

	/* void printf(const OS_CHAR * fmt, ...)
	{
		va_list ap;
		va_start(ap, fmt);
		FCGX_VFPrintF(request->out, fmt, ap);
		va_end(ap);
	} */

	static int triggerHeaderSent(OS * p_os, int params, int, int, void*)
	{
		FCGX_OS * os = (FCGX_OS*)p_os;
		os->header_sent = true;
		return 0;
	}

	static int registerShutdownFunction(OS * p_os, int params, int, int, void*)
	{
		if(params > 0){
			FCGX_OS * os = (FCGX_OS*)p_os;
			int offs = os->getAbsoluteOffs(-params);
			os->pushValueById(os->shutdown_funcs_id);
			for(int i = 0; i < params; i++){
				os->pushStackValue();
				os->pushStackValue(offs+i);
				os->pushStackValue();
				os->setProperty();
			}
		}
		return 0;
	}

	static int decodeHexChar(OS_CHAR c)
	{
		if(c >= '0' && c <= '9') return      c - '0';
		if(c >= 'A' && c <= 'F') return 10 + c - 'A';
		if(c >= 'a' && c <= 'f') return 10 + c - 'a';
		return 0;
	}

	static OS_CHAR decodeHexCode(const OS_CHAR * s)
	{
		// OS_ASSERT(s[0] && s[1]);
		int c = decodeHexChar(s[0]) * 16 + decodeHexChar(s[1]);
		return (OS_CHAR)c;
	}

	static int urlDecode(OS * os, int params, int, int, void*)
	{
		if(params >= 1){
			String str = os->toString(-params+0);
			const OS_CHAR * s = str;
			const OS_CHAR * end = s + str.getLen();
			
			Core::Buffer buf(os);
			for(; s < end;){
				if(*s == OS_TEXT('%')){
					if(s+3 <= end){
						buf.append(decodeHexCode(s+1));
					}
					s += 3;
				}else if(*s == OS_TEXT('+')){
					buf.append(OS_TEXT(' '));
					s++;
				}else{
					buf.append(*s++);
				}
			}
			os->pushString(buf);
			return 1;
		}
		return 0;
	}

	void initUrlLibrary()
	{
		FuncDef funcs[] = {
			{"decode", FCGX_OS::urlDecode},
			{}
		};
		getModule(OS_TEXT("url"));
		setFuncs(funcs);
		pop();
	}

	void triggerShutdownFunctions()
	{
		pushValueById(shutdown_funcs_id);
		Core::Value list = core->getStackValue(-1);
		Core::GCValue * obj = list.getGCValue();
		OS_ASSERT(OS_VALUE_TYPE(list) == OS_VALUE_TYPE_OBJECT && obj);
		if(obj->table && obj->table->count){
			Core::Property * prop = obj->table->last;
			for(; prop; prop = prop->prev){
				if(prop->value.isFunction()){
					core->pushValue(prop->value);
					pushNull();
					call();
				}
			}
		}
		pop();
	}

	void initGlobalFunctions()
	{
		FuncDef funcs[] = {
			{"registerShutdownFunction", FCGX_OS::registerShutdownFunction},
			{"triggerHeaderSent", FCGX_OS::triggerHeaderSent},
			{}
		};
		pushGlobals();
		setFuncs(funcs);
		pop();
	}

	void processRequest(FCGX_Request * p_request)
	{
		request = p_request;

		pushStackValue(OS_REGISTER_USERPOOL);
		newObject();
		shutdown_funcs_id = getValueId();
		addProperty();

		initGlobalFunctions();
		initUrlLibrary();

		initEnv("_SERVER", request->envp);

		newObject();
		setGlobal("_POST");
		
		newObject();
		setGlobal("_GET");
		
		newObject();
		setGlobal("_FILES");
		
		newObject();
		setGlobal("_COOKIE");

#if 0
#define OS_AUTO_TEXT(exp) OS_TEXT(#exp)
		eval(OS_AUTO_TEXT(
			if('HTTP_COOKIE' in _SERVER)
			for(var k, v in _SERVER.HTTP_COOKIE.split(';')){
				v = v.trim().split('=')
				if(#v == 2){
					_COOKIE[v[0]] = v[1]
				}
			}	
		));
#endif

		getGlobal("_SERVER");
		getProperty("CONTENT_LENGTH");
		int content_length = popInt();

		int post_max_size = 1024*1024*8;
		if(content_length > post_max_size){
			FCGX_FPrintF(request->out, "POST Content-Length of %d bytes exceeds the limit of %d bytes", content_length, post_max_size);
			return;
		}

		getGlobal("_SERVER");
		getProperty("CONTENT_TYPE");
		String content_type = popString();

		const char * multipart_form_data = "multipart/form-data;";
		int multipart_form_data_len = (int)strlen(multipart_form_data);

		MPFD::Parser POSTParser = MPFD::Parser();
		if(content_length > 0 && content_type.getLen() > 0 && strncmp(content_type.toChar(), multipart_form_data, multipart_form_data_len) == 0){
			POSTParser.SetTempDirForFileUpload("/tmp");
			// POSTParser.SetMaxCollectedDataLength(20*1024);
			POSTParser.SetContentType(content_type.toChar());

			int max_temp_buf_size = (int)(1024*1024*0.1);
			int temp_buf_size = content_length < max_temp_buf_size ? content_length : max_temp_buf_size;
			char * temp_buf = new char[temp_buf_size + 1];
			for(int cur_len; (cur_len = FCGX_GetStr(temp_buf, temp_buf_size, request->in)) > 0;){
				POSTParser.AcceptSomeData(temp_buf, cur_len);
			}
			delete [] temp_buf;
			temp_buf = NULL;
			
			// POSTParser.SetExternalDataBuffer(buf, len);
			POSTParser.FinishData();

			std::map<std::string, MPFD::Field *> fields = POSTParser.GetFieldsMap();
			// FCGX_FPrintF(request->out, "Have %d fields<p>\n", fields.size());

			std::map<std::string, MPFD::Field *>::iterator it;
			for(it = fields.begin(); it != fields.end(); it++){
				MPFD::Field * field = fields[it->first];
				if(field->GetType() == MPFD::Field::TextType){
					getGlobal("_POST");
					pushString(field->GetTextTypeContent().c_str());
					setSmartProperty(it->first.c_str());
				}else{
					getGlobal("_FILES");
					newObject();
					{
						pushStackValue();
						pushString(field->GetFileName().c_str());
						setProperty("name");
						
						pushStackValue();
						pushString(field->GetFileMimeType().c_str());
						setProperty("type");
						
						pushStackValue();
						pushString(field->GetTempFileNameEx().c_str());
						setProperty("tmp_name");
						
						pushStackValue();
						pushNumber(getFileSize(field->GetTempFileNameEx().c_str()));
						setProperty("size");
					}
					setSmartProperty(it->first.c_str());
				}
			}
		}
		
		initEnv("_ENV", environ);
		
		getGlobal("_SERVER");
		getProperty("SCRIPT_FILENAME");
		String script_filename = popString();
		
		String ext = getFilenameExt(script_filename);
		if(ext == OS_EXT_SOURCECODE || ext == OS_EXT_TEMPLATE){
			require(script_filename, true);
		}else{
			// TODO: output not OS file
			if(!header_sent){
				header_sent = true;
				if(ext == ".txt"){
					FCGX_PutS("Content-type: text/plain\r\n", request->out);
				}else{
					FCGX_PutS("Content-type: text/html\r\n", request->out);
				}
				FCGX_PutS("\r\n", request->out);
			}
			void * f = openFile(script_filename, "rb");
			if(f){
				const int BUF_SIZE = 1024*256;
				int size = getFileSize(f);
				void * buf = malloc(BUF_SIZE < size ? BUF_SIZE : size OS_DBG_FILEPOS);
				for(int i = 0; i < size; i += BUF_SIZE){
					int len = BUF_SIZE < size - i ? BUF_SIZE : size - i;
					readFile(buf, len, f);
					FCGX_PutStr((const char*)buf, len, request->out);
				}
				closeFile(f);
				free(buf);				
			}else{
				FCGX_PutS("Error open file: ", request->out);
				FCGX_PutS(script_filename, request->out);
			}
		}

		triggerShutdownFunctions();
		// FCGX_Finish_r(request);
		FCGX_FFlush(request->out);
	}
};

#if 0
static void printEnv(FCGX_Stream *out, char *label, char **envp)
{
    FCGX_FPrintF(out, "%s:<br>\n<pre>\n", label);
    for( ; *envp != NULL; envp++) {
        FCGX_FPrintF(out, "%s\n", *envp);
    }
    FCGX_FPrintF(out, "</pre><p>\n");
}
#endif

void log(const char * msg)
{
	FILE * f = fopen("/tmp/os-fcgi.log", "wt");
	if(f){
		fwrite(msg, strlen(msg), 1, f);
		fclose(f);
	}
}

void * doit(void * a)
{
	const char * port = ":9000";
    int listen_queue_backlog = 400;

    int  listen_socket = FCGX_OpenSocket(port, listen_queue_backlog);
    if(listen_socket < 0){
		printf("listen_socket < 0 \n");
		exit(1);
	}

    FCGX_Request request;
    if(FCGX_InitRequest(&request, listen_socket, 0)){
		printf("error init request \n");
		exit(1);
	}

#ifndef _MSC_VER
	static pthread_mutex_t accept_mutex = PTHREAD_MUTEX_INITIALIZER;
#endif

    for(;;){
#ifndef _MSC_VER
		pthread_mutex_lock(&accept_mutex);
#endif		
		int rc = FCGX_Accept_r(&request);
#ifndef _MSC_VER
		pthread_mutex_unlock(&accept_mutex);
#endif
		if(rc){
			printf("error accept code: %d\n", rc);
			exit(1);
		}

		FCGX_OS * os = OS::create(new FCGX_OS());
		os->processRequest(&request);
        os->release();
		FCGX_Finish_r(&request);
    }
}

#ifdef _MSC_VER
int _tmain(int argc, _TCHAR* argv[])
#else
int main(int argc, char * argv[])
#endif
{
	if(FCGX_Init()){
		exit(1); 
	}

#ifndef _MSC_VER
	const int THREAD_COUNT = 8;
	pthread_t id[THREAD_COUNT];
	for(int i = 1; i < THREAD_COUNT; i++){
        pthread_create(&id[i], NULL, doit, (void*)i);
	}
#endif
	doit(NULL);

	return 0;
}

