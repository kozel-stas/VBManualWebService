package core.config;

import com.google.common.base.Preconditions;

import javax.annotation.Nonnull;

public enum ConfigFields {

    RPC_PORT("rpc.port", String.valueOf(ConfigConstants.RPC_PORT)) {
        @Override
        public void acceptConfig(@Nonnull String config) {
            ConfigConstants.RPC_PORT = Integer.valueOf(config);
        }
    },;

    private final String configName;
    private final String defaultConfig;

    ConfigFields(String configName, String defaultConfig) {
        this.configName = configName;
        this.defaultConfig = defaultConfig;
    }

    public abstract void acceptConfig(@Nonnull String config);

    public String getDefaultConfig() {
        return defaultConfig;
    }

    public static ConfigFields fromValue(@Nonnull String name) {
        Preconditions.checkNotNull(name);
        for (ConfigFields config : ConfigFields.values()) {
            if (config.configName.equals(name.toLowerCase().trim())) {
                return config;
            }
        }
        return null;
    }

}