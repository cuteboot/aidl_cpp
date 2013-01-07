package extra;
import SubSample;


interface ICrypto {
    void initCheck();
    boolean isCryptoSchemeSupported(in int[] uuid);
    void createPlugin( in int[] uuid, in void[] data, long size);
    void destroyPlugin();
    boolean requiresSecureDecoderComponent( String mime);
    long decrypt( boolean secure, in int[] key, in int[] iv, int mode, in void[] srcPtr, in SubSample[] subSamples, long numSubSamples, out void[] dstPtr, String errorDetailMsg);
}
