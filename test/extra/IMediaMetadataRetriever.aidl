package extra;
import extra.IMemory;
import extra.KeyedVectorString8String8;


interface IMediaMetadataRetriever {
    void disconnect();
    void setDataSourceUrl( String srcUrl, KeyedVectorString8String8 headers);
    void setDataSourceFd(int fd, long offset, long length);
    IMemory getFrameAtTime(long timeUs, int option);
    IMemory extractAlbumArt();
    String  extractMetadata(int keyCode);
}
