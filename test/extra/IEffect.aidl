package extra;
import extra.IMemory;


interface IEffect {
    void enable();
    void disable();
    void command(int cmdCode, int cmdSize, in void[] pCmdData, inout int[] pReplySize, out void[] pReplyData);
    void disconnect();
    IMemory getCblk();
}
