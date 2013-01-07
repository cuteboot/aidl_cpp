package extra;
import omx_message;


interface IOMXObserver {
    void onMessage(in omx_message msg);
}
