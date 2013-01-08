package extra;

import import.zParcel;

interface IPhoneClient {
    void Response(int token, int message, int result,
        int ivalue, out zParcel extra);
    void Unsolicited(int message, int ivalue, String svalue);
}
