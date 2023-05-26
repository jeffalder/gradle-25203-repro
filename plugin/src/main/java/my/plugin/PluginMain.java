package my.plugin;

import org.gradle.api.Plugin;
import org.gradle.api.invocation.Gradle;

public class PluginMain implements Plugin<Gradle> {
    @Override
    public void apply(Gradle target) {
        System.out.println("==== PLUGIN APPLIED SUCCESSFULLY ====");
    }
}
