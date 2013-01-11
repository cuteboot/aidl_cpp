package extra;
import import.DrmInfoEvent;
import import.status_t;


interface IDrmServiceListener {
    status_t notify(in DrmInfoEvent event);
}
