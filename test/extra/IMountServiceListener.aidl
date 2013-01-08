package extra;

interface IMountServiceListener {
    void onUsbMassStorageConnectionChanged(boolean connected);
    void onStorageStateChanged(String path, String oldState,
        String newState);
}
