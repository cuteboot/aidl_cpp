package extra;
import import.DrmInfoEvent;


interface IDrmServiceListener {
    void notify(out DrmInfoEvent event);
}
