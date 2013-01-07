
package aidl;

import aidl.IWifiClient;
import aidl.ConfiguredStation;

interface IWifiService {
    void Register(in IWifiClient client, int flags);
    void SetEnabled(boolean enabled);
    void SendCommand(int command, int arg1, int arg2);
    void AddOrUpdateNetwork(in ConfiguredStation cs);
}
