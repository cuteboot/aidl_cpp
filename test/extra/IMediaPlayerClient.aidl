package extra;

interface IMediaPlayerClient {
    void notify(int msg, int ext1, int ext2, const Parcel[] obj);
}
