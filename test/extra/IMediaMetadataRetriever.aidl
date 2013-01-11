package extra;
import extra.IMemory;
import import.status_t;
import import.CString;

interface IMediaMetadataRetriever {
    void disconnect();
    status_t setDataSourceUrl( in CString srcUrl, in CString/*KeyedVector*/ * headers);
    status_t setDataSourceFd(int fd, long offset, long length);
    IMemory getFrameAtTime(long timeUs, int option);
    IMemory extractAlbumArt();
    CString  extractMetadata(int keyCode);
}
