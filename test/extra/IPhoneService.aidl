package extra;
import extra.IPhoneClient;


interface IPhoneService {
    void Register(IPhoneClient client, int flags);
    void Request(IPhoneClient client, int token, int message, int ivalue, String svalue);
}
