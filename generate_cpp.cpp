
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
    const char *from;
    const char *to;
} TYPEMAP;

static const char *this_proxy_interface;
static const char *this_interface;

static TYPEMAP* lookup_type(const char *name)
{
static TYPEMAP typemap[] = {
    {"int", "int", "%s = data.readInt32();\n", "data.writeInt32(%s);\n"},
    {"long", "long", "%s = data.readLong();\n", "data.writeLong(%s);\n"},
    {"byte", "byte", "%s = data.readByte();\n", "data.writeByte(%s);\n"},
    {"boolean", "bool", "%s = (data.readInt32() != 0);\n", "data.writeInt32((int)%s);\n"},
    {"String", "const String16&", "%s = data.readString16();\n", "data.writeString16(%s);\n"},
    {"IBinder", "const sp<IBinder>&", "%s = data.readStrongBinder();\n", "data.writeStrongBinder(%s->asBinder());\n"},
    {"CharSequence", "string", "%s = data.readstring();\n", "data.writestring(%s);\n"},
    {"IBinderThreadPriorityService", "const sp<IBinderThreadPriorityService>&",
        "%s = data.readIBinderThreadPriorityService();\n", "data.writeIBinderThreadPriorityService(%s);\n"},
    {"WorkSource", "WorkSource", "%s = data.readWorkSource();\n", "data.writeWorkSource(%s);\n"},
    {"float", "float", "%s = data.readfloat();\n", "data.writefloat(%s);\n"},
    {0, 0, 0, 0}};

    TYPEMAP *p = typemap;
    while (p->name && strcmp(name, p->name))
        p++;
    if (!p->name) {
        printf ("lookup_type: failed to find '%s'\n", name);
        exit(1);
        return NULL;
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
#if 0
class Type;
struct CppVariable
{
    Type* type;
    string name;
    int dimension;
    CppVariable(Type* t, const string& n) :type(t), name(n), dimension(0) { };
    virtual ~CppVariable() {};
};
class VariableFactory
{
public:
    VariableFactory(const string& base); // base must be short
    CppVariable* Get(Type* type);
    CppVariable* Get(int index);
private:
    vector<CppVariable*> m_vars;
    string m_base;
    int m_index;
};
// =================================================
VariableFactory::VariableFactory(const string& base) :m_base(base), m_index(0) { }
CppVariable*
VariableFactory::Get(Type* type)
{
    char name[100];
    sprintf(name, "%s%d", m_base.c_str(), m_index);
    m_index++;
    CppVariable* v = new CppVariable(type, name);
    m_vars.push_back(v);
    return v;
}
CppVariable*
VariableFactory::Get(int index)
{
    return m_vars[index];
}
// =================================================
string
gather_comments(extra_text_type* extra)
{
    string s;
    while (extra) {
        if (extra->which == SHORT_COMMENT) {
            s += extra->data;
        }
        else if (extra->which == LONG_COMMENT) {
            s += "/*";
            s += extra->data;
            s += "*/";
        }
        extra = extra->next;
    }
    return s;
}
string
append(const char* a, const char* b)
{
    string s = a;
    s += b;
    return s;
}
#endif
static string makeup(const char *name)
{
    string transactCodeName = name;
    for(int i = 0; i < (int)transactCodeName.length(); i++)
        transactCodeName[i] = toupper(transactCodeName[i]);
    return transactCodeName;
}

static string makelow(const char *name)
{
    string transactCodeName = name;
    for(int i = 0; i < (int)transactCodeName.length(); i++)
        transactCodeName[i] = tolower(transactCodeName[i]);
    return transactCodeName;
}

static void generate_client_h(FILE *outputfd, interface_item_type* aitem)
{
    interface_item_type* item = aitem;
    fprintf(outputfd, "#ifndef ANDROID_%s_H\n#define ANDROID_%s_H\n\n", this_proxy_interface, this_proxy_interface);
    fprintf(outputfd, "#include <utils/Errors.h>\n");
    fprintf(outputfd, "#include <binder/IInterface.h>\n\n");
    fprintf(outputfd, "namespace android {\n\n");
    fprintf(outputfd, "class %s : public IInterface\n{\npublic:\n\n", this_proxy_interface);
    fprintf(outputfd, "    DECLARE_META_INTERFACE(%s);\n", this_interface);
    while (item) {
        if (item->item_type == METHOD_TYPE) {
            int i;
            const method_type* method =  (method_type*)item;
            string transactCodeName = makeup(method->name.data);
            
            string dim;
            for (i=0; i<(int)method->type.dimension; i++)
                dim += "[]";
            fprintf(outputfd, "    %s%s %s(", "virtual status_t"/*method->type.type.data*/, dim.c_str(), method->name.data);
            arg_type* arg = method->args;
            while (arg) {
                fprintf(outputfd, "%s %s", lookup_type(arg->type.type.data)->decl, arg->name.data);
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
    fprintf(outputfd, "    status_t onTransact(uint32_t code, const Parcel& data, Parcel *reply, uint32_t flags);\n");
    fprintf(outputfd, "}; // namespace android\n\n#endif ANDROID_%s_H\n", this_proxy_interface);
}

static void generate_client_cpp(FILE *outputfd, interface_item_type* aitem)
{
    interface_item_type* item = aitem;
    fprintf(outputfd, "#define LOG_TAG \"%s\"\n", this_proxy_interface);
    fprintf(outputfd, "//#define LOG_NDEBUG 0\n");
    fprintf(outputfd, "#include <utils/Log.h>\n");
    fprintf(outputfd, "#include <stdint.h>\n");
    fprintf(outputfd, "#include <sys/types.h>\n");
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
            string transactCodeName = makeup(method->name.data);
            string dimstr;
            for (int i=0; i<(int)method->type.dimension; i++)
                dimstr += "[]";
            fprintf(outputfd, "%s\n", gather_comments(method->comments_token->extra).c_str());
            fprintf(outputfd, "%s%s %s(", "virtual status_t" /*method->type.type.data*/, dimstr.c_str(), method->name.data);
            arg_type* arg = method->args;
            while (arg) {
                fprintf(outputfd, "%s %s", lookup_type(arg->type.type.data)->decl, arg->name.data);
                arg = arg->next;
                if (arg)
                    fprintf(outputfd, ", ");
            }
            fprintf(outputfd, ")\n{\n    Parcel data, reply;\n");
            if (strcmp(method->type.type.data, "void")) {
printf("[%s:%d] result type not void\n", __FUNCTION__, __LINE__);
//exit(1);
            }
            fprintf(outputfd, "    data.writeInterfaceToken(%s::getInterfaceDescriptor());\n", this_proxy_interface);
            arg = method->args;
            while (arg) {
                int dir = convert_direction(arg->direction.data);
                if (dir == OUT_PARAMETER && arg->type.dimension) {
printf("[%s:%d]\n", __FUNCTION__, __LINE__);
exit(1);
                }
                else if (dir & IN_PARAMETER) {
                    fprintf(outputfd, "    ");
                    fprintf(outputfd, lookup_type(arg->type.type.data)->to, arg->name.data);
                }
                arg = arg->next;
            }
            fprintf(outputfd, "    return remote()->transact(%s, data, &reply);\n}\n", transactCodeName.c_str());
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
            
            fprintf(outputfd, "case %s: {\n", transactCodeName.c_str());
            arg_type* arg = method->args;
            while (arg) {
        printf("[%s:%d] typename %s\n", __FUNCTION__, __LINE__, arg->type.type.data);
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
                    fprintf(stderr, "aidl:internal error %s:%d\n", __FILE__, __LINE__);
                arg = arg->next;
                argindex++;
            }
            fprintf(outputfd, "    %s(", method->name.data);
            int i = 0;
            while (argindex-- > 0) {
                fprintf(outputfd, "_arg%d", i++);
                if (argindex > 0)
                    fprintf(outputfd, ", ");
            }
            fprintf(outputfd, ")");
            if (strcmp(method->type.type.data, "void")) {
printf("[%s:%d] return type not void\n", __FUNCTION__, __LINE__);
//exit(1);
            }
            // out parameters
            argindex = 0;
            arg = method->args;
            while (arg) {
                if (convert_direction(arg->direction.data) & OUT_PARAMETER)
                    fprintf(outputfd, "data.%s(%s);\n", lookup_type(arg->type.type.data)->to, arg->name.data);
                argindex++;
                arg = arg->next;
            }
            fprintf(outputfd, ";\n    return NO_ERROR;\n    }\n");
        }
        item = item->next;
    }
    fprintf(outputfd, "}\nreturn BBinder::onTransact(code, data, reply, flags);\n}\n");
    fprintf(outputfd, "\n}; // namespace android\n");
}

static FILE *newfile(char *filebuff, const string& filename, const char *interface, const char *suffix, const string& originalSrc)
{
    strcpy(filebuff, filename.c_str());
    dirname(filebuff);
    strcat(filebuff, "/");
    strcat(filebuff, interface);
    strcat(filebuff, suffix);
    printf("outputting... filename=%s\n", filebuff);
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

printf("[%s:%d] starting\n", __FUNCTION__, __LINE__);
    FILE *outputfd = newfile(filebuff, filename, this_proxy_interface, ".h", originalSrc);
    generate_client_h(outputfd, iface->interface_items);
    fclose(outputfd);
    outputfd = newfile(filebuff, filename, this_proxy_interface, ".cpp", originalSrc);
    generate_client_cpp(outputfd, iface->interface_items);
    fclose(outputfd);

    return 0;
}
