package extra;

interface IEffectClient {
    void controlStatusChanged(boolean controlGranted);
    void enableStatusChanged(boolean enabled);
    void commandExecuted(int cmdCode, int cmdSize, in void * pCmdData,
        int replySize, out void * pReplyData);
}
