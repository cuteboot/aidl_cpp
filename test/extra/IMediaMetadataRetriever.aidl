package extra;
import extra.IMemory;


interface IMediaMetadataRetriever {
    void disconnect();
    void setDataSourceUrl( String srcUrl, in String[] headers);
    void setDataSourceFd(int fd, long offset, long length);
    IMemory getFrameAtTime(long timeUs, int option);
    IMemory extractAlbumArt();
    String  extractMetadata(int keyCode);
}
