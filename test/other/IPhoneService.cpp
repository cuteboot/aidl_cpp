/*
  PhoneService 
 */

#include <binder/Parcel.h>
#include <phone/IPhoneService.h>
#include <phone/IPhoneClient.h>


namespace android {

class BpPhoneService : public BpInterface<IPhoneService>
{
public:
    BpPhoneService(const sp<IBinder>& impl)
	: BpInterface<IPhoneService>(impl)
    {
    }

    void Register(const sp<IPhoneClient>& client, UnsolicitedMessages flags) {
	Parcel data, reply;
	data.writeInterfaceToken(IPhoneService::getInterfaceDescriptor());
	data.writeStrongBinder(client->asBinder());
	data.writeInt32(flags);
	remote()->transact(REGISTER, data, &reply, IBinder::FLAG_ONEWAY);
    }

    void Request(const sp<IPhoneClient>& client, int token, int message, int ivalue, const String16& svalue) {
	Parcel data, reply;
	data.writeInterfaceToken(IPhoneService::getInterfaceDescriptor());
	data.writeStrongBinder(client->asBinder());
	data.writeInt32(token);
	data.writeInt32(message);
	data.writeInt32(ivalue);
	data.writeString16(svalue);
	remote()->transact(REQUEST, data, &reply, IBinder::FLAG_ONEWAY);
    }
};

IMPLEMENT_META_INTERFACE(PhoneService, "klaatu.platform.IPhoneService")

// ----------------------------------------------------------------------------
}; // namespace Android
