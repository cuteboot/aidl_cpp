/*
  IWifiService
*/

#ifndef _IWIFI_SERVICE_H
#define _IWIFI_SERVICE_H

#include <binder/IInterface.h>
#include <wifi/IWifiClient.h>

namespace android {

// ----------------------------------------------------------------------------

enum WifiClientFlag {
    WIFI_CLIENT_FLAG_NONE                = 0x00,

    WIFI_CLIENT_FLAG_STATE               = 0x01,
    WIFI_CLIENT_FLAG_SCAN_RESULTS        = 0x02,
    WIFI_CLIENT_FLAG_CONFIGURED_STATIONS = 0x04,
    WIFI_CLIENT_FLAG_INFORMATION         = 0x08,
    WIFI_CLIENT_FLAG_RSSI                = 0x10,
    WIFI_CLIENT_FLAG_LINK_SPEED          = 0x20,

    WIFI_CLIENT_FLAG_BROADCAST           = 0x0f,  // Most common flags
    WIFI_CLIENT_FLAG_ALL                 = 0xffff
};


/**
 * Each application should make a single IWifiService connection 
 */
    
class IWifiService : public IInterface
{
public:
    enum { 
	COMMAND_START_SCAN,            // set arg=1 to force active
	COMMAND_ENABLE_RSSI_POLLING,   // set arg=1 to enable
	COMMAND_ENABLE_BACKGROUND_SCAN, // set arg=1 to enable
	COMMAND_REMOVE_NETWORK,    // arg is network_id
	COMMAND_SELECT_NETWORK,    // arg is network_id
	COMMAND_ENABLE_NETWORK,    // arg is network_id, arg2=disable others
	COMMAND_DISABLE_NETWORK,    // arg is network_id
	COMMAND_RECONNECT,
	COMMAND_DISCONNECT,
	COMMAND_REASSOCIATE
    };

protected:
    enum {
	REGISTER = IBinder::FIRST_CALL_TRANSACTION,
	SET_ENABLED,
	SEND_COMMAND,
	ADD_OR_UPDATE_NETWORK
    };

public:
    DECLARE_META_INTERFACE(WifiService);

    virtual void Register(const sp<IWifiClient>& client, WifiClientFlag flags) = 0;
    virtual void SetEnabled(bool enabled) = 0;
    virtual void SendCommand(int command, int arg1, int arg2) = 0;
    virtual void AddOrUpdateNetwork(const ConfiguredStation& cs) = 0;
};

// ----------------------------------------------------------------------------

class BnWifiService : public BnInterface<IWifiService>
{
public:
    virtual status_t onTransact(uint32_t code, 
				const Parcel& data,
				Parcel* reply, 
				uint32_t flags = 0);
};

// ----------------------------------------------------------------------------

}; // namespace android

#endif // _IWIFI_SERVICE_H

