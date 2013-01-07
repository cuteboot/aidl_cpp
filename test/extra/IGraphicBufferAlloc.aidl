package extra;
import extra.GraphicBuffer;


interface IGraphicBufferAlloc {
    GraphicBuffer createGraphicBuffer(int w, int h, int format, int usage, void[]  error);
}
