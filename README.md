# gradle-25203-repro
Repro for https://github.com/gradle/gradle/issues/25203

To reproduce the issue, run `./fail.sh`. Ensure you have an internet connection (to download gradle). Any Java version should suffice.

After `|||||||||||| FAILS:`, you see the failure as the daemon for Gradle 8.1.1 vanilla doesn't have the plugin referenced by the init script.

After `|||||||||||| PASSES:`, you'll see that we have to restart the daemon for the plugin library to be recognized.
