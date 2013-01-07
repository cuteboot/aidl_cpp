
package aidl;

import aidl.ScannedStation;
import aidl.ConfiguredStation;
import aidl.WifiInformation;

interface IWifiClient {
    void State(int state);
    void ScanResults(in ScannedStation[] scandata);
    void ConfiguredStations(in ConfiguredStation[] configdata);
    void Information(in WifiInformation info);
    void Rssi(int rssi);
    void LinkSpeed(int link_speed);
}
