/*
 */

#include <phone/IPhoneClient.h>
#include <binder/Parcel.h>

// #include <utils/String8.h>

namespace android {

// ----------------------------------------------------------------------

class BpPhoneClient : public BpInterface<IPhoneClient>
{
public:
    BpPhoneClient(const sp<IBinder>& impl)
	: BpInterface<IPhoneClient>(impl)
    {
    }

    void Response(int token, int message, int result, int ivalue, const Parcel& extra)
    {
        Parcel data, reply;
        data.writeInterfaceToken(IPhoneClient::getInterfaceDescriptor());
        data.writeInt32(token);
	data.writeInt32(message);
	data.writeInt32(result);
	data.writeInt32(ivalue);
	if (extra.dataSize())
	    data.write(extra.data(), extra.dataSize());
        remote()->transact(RESPONSE, data, &reply, IBinder::FLAG_ONEWAY);
    }

    void Unsolicited(int message, int ivalue, const String16& svalue)
    {
        Parcel data, reply;
        data.writeInterfaceToken(IPhoneClient::getInterfaceDescriptor());
        data.writeInt32(message);
	data.writeInt32(ivalue);
	data.writeString16(svalue);
        remote()->transact(UNSOLICITED, data, &reply, IBinder::FLAG_ONEWAY);
    }
};

// ---------------------------------------------------------------------------

status_t BnPhoneClient::onTransact( uint32_t code, 
				    const Parcel& data, 
				    Parcel* reply, 
				    uint32_t flags )
{
    switch(code) {
    case RESPONSE: {
	CHECK_INTERFACE(IPhoneClient, data, reply);
	int token   = data.readInt32();
	int message = data.readInt32();
	int result  = data.readInt32();
	int ivalue  = data.readInt32();
	Parcel extra;
	if (data.dataAvail()) {
	    extra.write(data.data()+data.dataPosition(), data.dataAvail());
	    extra.setDataPosition(0);
	}
	Response(token, message, result, ivalue, extra);
	return NO_ERROR;
    } break;

    case UNSOLICITED: {
	CHECK_INTERFACE(IPhoneClient, data, reply);
	int message = data.readInt32();
	int ivalue  = data.readInt32();
	String16 svalue = data.readString16();
	Unsolicited(message, ivalue, svalue);
	return NO_ERROR;
    } break;
    
    }
    return BBinder::onTransact(code, data, reply, flags);
}

IMPLEMENT_META_INTERFACE(PhoneClient, "PhoneClient")

// ----------------------------------------------------------------------------

}; // namespace Android
