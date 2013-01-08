
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string>
#include <vector>
#include <set>
#include <stdarg.h>
#include <libgen.h>
#include "aidl_language.h"
#include "generate_java.h" // for gather_comments()

using namespace std;

typedef struct {
    const char *name;
    const char *decl;
    const char *declparam;
    const char *from;
    const char *to;
} TYPEMAP;

static const char *this_proxy_interface;
static const char *this_interface;

static TYPEMAP* lookup_type(const char *name)
{
static TYPEMAP typemap[] = {
    {"int", "int", "int", "%s = data.readInt32();\n", "data.writeInt32(%s);\n"},
    {"long", "long", "long", "%s = data.readLong();\n", "data.writeLong(%s);\n"},
    {"byte", "byte", "byte", "%s = data.readByte();\n", "data.writeByte(%s);\n"},
    {"boolean", "bool", "bool", "%s = (data.readInt32() != 0);\n", "data.writeInt32((int)%s);\n"},
    {"String", "String16", "const String16&", "%s = data.readString16();\n", "data.writeString16(%s);\n"},
    {"IBinder", "const sp<IBinder>&", "const sp<IBinder>&", "%s = data.readStrongBinder();\n", "data.writeStrongBinder(%s);\n"},
    {"CharSequence", "string", "string", "%s = data.readstring();\n", "data.writestring(%s);\n"},
    {"IBinderThreadPriorityService", "const sp<IBinderThreadPriorityService>&", "sp<IBinderThreadPriorityService>",
        "%s = data.readIBinderThreadPriorityService();\n", "data.writeIBinderThreadPriorityService(%s);\n"},
    {"WorkSource", "WorkSource", "WorkSource", "%s = data.readInt32();\n", "data.writeInt32(0);\n"},
    {"float", "float", "float", "%s = data.readfloat();\n", "data.writefloat(%s);\n"},
#if 0
    {"IWifiClient", "const sp<IWifiClient>&", "const sp<IWifiClient>&", "%s = data.readStrongWifiClient();\n", "data.writeStrongWifiClient(%s);\n"},
    {"ConfiguredStation", "const sp<ConfiguredStation>&", "const sp<ConfiguredStation>&", "%s = data.readStrongConfiguredStation();\n", "%s.writeToParcel(&data);\n"},
    {"ScannedStation", "const sp<ScannedStation>&", "const sp<ScannedStation>&", "%s = data.readStrongScannedStation();\n", "%s.writeToParcel(&data);\n"},
    {"WifiInformation", "const sp<WifiInformation>&", "const sp<WifiInformation>&", "%s = data.readStrongWifiInformation();\n", "%s.writeToParcel(&data);\n"},
#endif
    {0, 0, 0, 0, 0}};

static TYPEMAP pattern =
    {"%s", "const sp<%s>&", "const sp<%s>&", "%%s = data.readStrong%s();\n", "%%s.writeToParcel(&data);\n"};
static char temps[5][100];
static TYPEMAP temp = {(const char *)temps[0], (const char *)temps[1], (const char *)temps[2], (const char *)temps[3], (const char *)temps[4]};

    TYPEMAP *p = typemap;
    while (p->name && strcmp(name, p->name))
        p++;
    if (!p->name) {
        sprintf(temps[0], pattern.name, name);
        sprintf(temps[1], pattern.decl, name);
        sprintf(temps[2], pattern.declparam, name);
        sprintf(temps[3], pattern.from, name);
        sprintf(temps[4], pattern.to, name);
        return &temp;
#if 0
        printf ("lookup_type: failed to find '%s'\n", name);
        exit(1);
        return NULL;
#endif
    }
    return p;
}
static string
escape_backslashes(const string& str)
{
    string result;
    const size_t I=str.length();
    for (size_t i=0; i<I; i++) {
        char c = str[i];
        if (c == '\\') {
            result += "\\\\";
        } else {
            result += c;
        }
    }
    return result;
}
static string makeup(const char *name)
{
    string transactCodeName;
    char ch, lastch = 'A';
    do {
        ch = *name++;
        if (isupper(ch) && islower(lastch))
            transactCodeName = transactCodeName + '_';
        lastch = ch;
        ch = toupper(ch);
        transactCodeName = transactCodeName + ch;
    } while (ch);
    return transactCodeName;
}

static string makelow(const char *name)
{
    string transactCodeName = name;
    for(int i = 0; i < (int)transactCodeName.length(); i++)
        transactCodeName[i] = tolower(transactCodeName[i]);
    return transactCodeName;
}

static void generate_header_file(FILE *outputfd, interface_item_type* aitem)
{
    interface_item_type* item = aitem;
    fprintf(outputfd, "#ifndef ANDROID_%s_H\n#define ANDROID_%s_H\n\n", makeup(this_proxy_interface).c_str(), makeup(this_proxy_interface).c_str());
    //fprintf(outputfd, "#include <utils/Errors.h>\n");
    fprintf(outputfd, "#include <binder/IInterface.h>\n\n");
    fprintf(outputfd, "namespace android {\n\n");
    fprintf(outputfd, "class %s : public IInterface\n{\npublic:\n", this_proxy_interface);
    fprintf(outputfd, "    DECLARE_META_INTERFACE(%s);\n", this_interface);
    while (item) {
        if (item->item_type == METHOD_TYPE) {
            int i;
            const method_type* method =  (method_type*)item;
            string transactCodeName = makeup(method->name.data);
            bool return_void = (strcmp(method->type.type.data, "void") == 0);
            
            string dimstr;
            for (i=0; i<(int)method->type.dimension; i++)
                dimstr += "[]";
            fprintf(outputfd, "    virtual ");
            if (return_void)
                fprintf(outputfd, "status_t");
            else
                fprintf(outputfd, "%s%s", lookup_type(method->type.type.data)->decl, dimstr.c_str());
            fprintf(outputfd, " %s(", method->name.data);
            arg_type* arg = method->args;
            while (arg) {
                fprintf(outputfd, "%s %s", lookup_type(arg->type.type.data)->declparam, arg->name.data);
                arg = arg->next;
                if (arg)
                    fprintf(outputfd, ", ");
            }
            fprintf(outputfd, ") = 0;\n");
        }
        item = item->next;
    }
    fprintf(outputfd, "};\n\n");

    fprintf(outputfd, "class Bn%s : public BnInterface<%s>\n{\npublic:\n", this_interface, this_proxy_interface);
    fprintf(outputfd, "    enum {\n");
    item = aitem;
    int once = 1;
    while (item) {
        if (item->item_type == METHOD_TYPE)
            fprintf(outputfd, "        %s", makeup(((method_type*)item)->name.data).c_str());
            if (once)
                fprintf(outputfd, " = IBinder::FIRST_CALL_TRANSACTION");
            once = 0;
            fprintf(outputfd, ",\n");
        item = item->next;
    }
    fprintf(outputfd, "    };\n");
    fprintf(outputfd, "    virtual status_t onTransact(uint32_t code, const Parcel& data,\n        Parcel *reply, uint32_t flags);\n");
    fprintf(outputfd, "}; // namespace android\n\n#endif // ANDROID_%s_H\n", makeup(this_proxy_interface).c_str());
}

static void generate_implementation(FILE *outputfd, interface_item_type* aitem)
{
    interface_item_type* item = aitem;
    fprintf(outputfd, "#define LOG_TAG \"%s\"\n", this_interface);
    fprintf(outputfd, "//#define LOG_NDEBUG 0\n\n");
    //fprintf(outputfd, "#include <utils/Log.h>\n");
    //fprintf(outputfd, "#include <stdint.h>\n");
    //fprintf(outputfd, "#include <sys/types.h>\n");
    fprintf(outputfd, "#include <binder/Parcel.h>\n");
    fprintf(outputfd, "#include <%s/%s.h>\n\n", makelow(this_interface).c_str(), this_proxy_interface);
    fprintf(outputfd, "namespace android {\n\n");
    fprintf(outputfd, "class Bp%s : public BpInterface<%s>\n{\n",
        this_interface, this_proxy_interface);
    fprintf(outputfd, "    Bp%s(const sp<IBinder>& impl)\n        : BpInterface<%s>(impl) { }\n",
        this_interface, this_proxy_interface);
    while (item) {
        if (item->item_type == METHOD_TYPE) {
            const method_type* method = (method_type*)item;
            bool return_void = (strcmp(method->type.type.data, "void") == 0);
            string transactCodeName = "::" + makeup(method->name.data);
            transactCodeName = this_interface + transactCodeName;
            transactCodeName = "Bn" + transactCodeName;
            string dimstr;
            for (int i=0; i<(int)method->type.dimension; i++)
                dimstr += "[]";
            fprintf(outputfd, "%s\n", gather_comments(method->comments_token->extra).c_str());
            fprintf(outputfd, "virtual ");
            if (return_void)
                fprintf(outputfd, "status_t");
            else
                fprintf(outputfd, "%s%s", lookup_type(method->type.type.data)->decl, dimstr.c_str());
            fprintf(outputfd, " %s(", method->name.data);
            arg_type* arg = method->args;
            while (arg) {
                fprintf(outputfd, "%s %s", lookup_type(arg->type.type.data)->declparam, arg->name.data);
                arg = arg->next;
                if (arg)
                    fprintf(outputfd, ", ");
            }
            fprintf(outputfd, ")\n{\n    Parcel data, reply;\n");
            fprintf(outputfd, "    data.writeInterfaceToken(%s::getInterfaceDescriptor());\n", this_proxy_interface);
            arg = method->args;
            while (arg) {
                int dir = convert_direction(arg->direction.data);
                if (dir == OUT_PARAMETER && arg->type.dimension) {
printf("[%s:%d] out + dim not supported\n", __FUNCTION__, __LINE__);
//exit(1);
                }
                else if (dir & IN_PARAMETER) {
                    fprintf(outputfd, "    ");
                    fprintf(outputfd, lookup_type(arg->type.type.data)->to, arg->name.data);
                }
                arg = arg->next;
            }
            fprintf(outputfd, "    ");
            if (return_void)
                fprintf(outputfd, "return ");
            fprintf(outputfd, "remote()->transact(%s, data, &reply)", transactCodeName.c_str());
            if (!return_void) {
                fprintf(outputfd, ";\n    // fail on exception\n    if (reply.readExceptionCode() != 0) return 0;\n    return reply.readInt32()");
                if (!strcmp(method->type.type.data, "boolean"))
                    fprintf(outputfd, " != 0");
            }
            fprintf(outputfd, ";\n}\n");
        }
        item = item->next;
    }
    fprintf(outputfd, "};\n\nIMPLEMENT_META_INTERFACE(%s, \"android.os.%s\");\n", this_interface, this_proxy_interface);
    item = aitem;
    //fprintf(outputfd, "static char const* getServiceName() { return \"%s\"; }\n", this_proxy_interface);
    fprintf(outputfd, "\nstatus_t Bn%s::onTransact(uint32_t code, const Parcel& data, Parcel *reply, uint32_t flags)\n{\n", this_interface);
    fprintf(outputfd, "switch (code) {\n");
    while (item) {
        if (item->item_type == METHOD_TYPE) {
            int argindex = 0;
            const method_type* method =  (method_type*)item;
            string transactCodeName = makeup(method->name.data);
            bool return_void = (strcmp(method->type.type.data, "void") == 0);
            
            fprintf(outputfd, "case %s: {\n", transactCodeName.c_str());
            fprintf(outputfd, "    CHECK_INTERFACE(%s, data, reply);\n", this_proxy_interface);
            arg_type* arg = method->args;
            while (arg) {
                char thisname[100];
                sprintf(thisname, "_arg%d", argindex);
                TYPEMAP* tp = lookup_type(arg->type.type.data);
                fprintf(outputfd, "    %s %s;\n", tp->decl, thisname);
                if (convert_direction(arg->direction.data) & IN_PARAMETER) {
                    fprintf(outputfd, "    ");
                    fprintf(outputfd, tp->from, thisname);
                }
#if 0
                else if (arg->type.dimension == 0) {
                    printf("[%s:%d]\n", __FUNCTION__, __LINE__);
                    exit(1);
                }
                else if (arg->type.dimension == 1) {
                    printf("[%s:%d]\n", __FUNCTION__, __LINE__);
                    exit(1);
                    }
#endif
                else
                    fprintf(stderr, "aidl:OUT param %s:%d\n", __FILE__, __LINE__);
                arg = arg->next;
                argindex++;
            }
            fprintf(outputfd, "    ");
            if (!return_void)
                fprintf(outputfd, "int res = ");
            fprintf(outputfd, "%s(", method->name.data);
            int i = 0;
            while (argindex-- > 0) {
                fprintf(outputfd, "_arg%d", i++);
                if (argindex > 0)
                    fprintf(outputfd, ", ");
            }
            fprintf(outputfd, ")");
            if (!strcmp(method->type.type.data, "boolean"))
                fprintf(outputfd, "? 1 : 0");
            fprintf(outputfd, ";\n");
            if (!return_void)
                fprintf(outputfd, "    reply->writeNoException();\n    reply->writeInt32(res);\n");
            // out parameters
            argindex = 0;
            arg = method->args;
            while (arg) {
                if (convert_direction(arg->direction.data) & OUT_PARAMETER)
                    fprintf(outputfd, "data.%s(%s);\n", lookup_type(arg->type.type.data)->to, arg->name.data);
                argindex++;
                arg = arg->next;
            }
            fprintf(outputfd, "    return NO_ERROR;\n    }\n");
        }
        item = item->next;
    }
    fprintf(outputfd, "}\nreturn BBinder::onTransact(code, data, reply, flags);\n}\n");
    fprintf(outputfd, "\n}; // namespace android\n");
}

static FILE *newfile(char *filebuff, const string& filename, const char *suffix, const string& originalSrc)
{
    strcpy(filebuff, filename.c_str());
    dirname(filebuff);
    strcat(filebuff, "/");
    strcat(filebuff, this_proxy_interface);
    strcat(filebuff, suffix);
    //printf("outputting... filename=%s\n", filebuff);
    FILE* outputfd = fopen(filebuff, "wb");
    if (!outputfd) {
        fprintf(stderr, "unable to open %s for write\n", filebuff);
        exit(1);
    }
    fprintf(outputfd, "/*\n * This file is auto-generated.  DO NOT MODIFY.\n"
         " * Original file: %s\n */\n", escape_backslashes(originalSrc).c_str());
    return outputfd;
}

// =================================================
int
generate_cpp(const string& filename, const string& originalSrc, interface_type* iface)
{
    if (filename == "-") {
printf("[%s:%d] stdout not supported!!\n", __FUNCTION__, __LINE__);
        exit(1);
    }
    if (iface->document_item.item_type != INTERFACE_TYPE_BINDER) {
printf("[%s:%d] error, no %d support yet!!!!!\n", __FUNCTION__, __LINE__, iface->document_item.item_type);
        exit(1);
    }

    this_proxy_interface = iface->name.data;
    this_interface = &this_proxy_interface[1];
    /* open file in binary mode to ensure that the tool produces the
     * same output on all platforms !!
     */
    char *filebuff = (char *)malloc(strlen(filename.c_str()) + strlen(this_proxy_interface) + 50);

//printf("[%s:%d] starting\n", __FUNCTION__, __LINE__);
    FILE *outputfd = newfile(filebuff, filename, ".h", originalSrc);
    generate_header_file(outputfd, iface->interface_items);
    fclose(outputfd);
    outputfd = newfile(filebuff, filename, ".cpp", originalSrc);
    generate_implementation(outputfd, iface->interface_items);
    fclose(outputfd);

    return 0;
}
