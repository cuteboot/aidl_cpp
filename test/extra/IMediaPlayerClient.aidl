package extra;

import import.zParcel;

interface IMediaPlayerClient {
    void notify(int msg, int ext1, int ext2, in zParcel * obj);
}
