/*
  IPhoneService
*/

#ifndef _IPHONE_SERVICE_H
#define _IPHONE_SERVICE_H

#include <binder/IInterface.h>
#include <phone/IPhoneClient.h>

namespace android {

// ----------------------------------------------------------------------------

/**
 * Each application should make a single IPhoneService connection 
 */
    
class IPhoneService : public IInterface
{
protected:
    enum {
	REGISTER = IBinder::FIRST_CALL_TRANSACTION,
	REQUEST
    };

public:
    DECLARE_META_INTERFACE(PhoneService);

    virtual void Register(const sp<IPhoneClient>& client, UnsolicitedMessages flags) = 0;
    virtual void Request(const sp<IPhoneClient>& client, int token, int message, int ivalue, const String16& svalue) = 0;
};

// ----------------------------------------------------------------------------

class BnPhoneService : public BnInterface<IPhoneService>
{
public:
    virtual status_t onTransact(uint32_t code, 
				const Parcel& data,
				Parcel* reply, 
				uint32_t flags = 0);
};

// ----------------------------------------------------------------------------

}; // namespace android

#endif // _IPHONE_SERVICE_H

