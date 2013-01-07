package extra;
import extra.DrmInfoEvent;


interface IDrmServiceListener {
    void notify(DrmInfoEvent event);
}
