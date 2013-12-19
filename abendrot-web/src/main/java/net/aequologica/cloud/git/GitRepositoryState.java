package net.aequologica.cloud.git;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Properties;

public class GitRepositoryState {

    
    // @formatter:off
    private final String branch;                // =${git.branch}
    private final String describe;              // =${git.commit.id.describe}
    private final String commitId;              // =${git.commit.id}
    private final String commitIdAbbrev;        // =${git.commit.id.abbrev}
    private final String buildUserName;         // =${git.build.user.name}
    private final String buildUserEmail;        // =${git.build.user.email}
    private final String buildTime;             // =${git.build.time}
    private final String commitUserName;        // =${git.commit.user.name}
    private final String commitUserEmail;       // =${git.commit.user.email}
    private final String commitMessageFull;     // =${git.commit.message.full}
    private final String commitMessageShort;    // =${git.commit.message.short}
    private final String commitTime;            // =${git.commit.time}
    private final String remoteOriginUrl;    // =${git.remote.origin.url}
    // @formatter:on
    
    public static Properties load(String module) throws IOException {
        Properties properties = new Properties();
        URL url = GitRepositoryState.class.getResource("/META-INF/resources/" + module + "/git.properties");
        if (url != null) {
            try (InputStream inputStream = url.openStream()) {
                properties.load(inputStream);
            }
        }
        return properties;
    }
    
    static private String safeToString(Object o) {
        return o == null ? "" : o.toString();
    }
    public GitRepositoryState(String module) throws IOException {
        this(load(module));
    }
    
    public GitRepositoryState(Properties properties) {
        // @formatter:off
        this.branch             = safeToString(properties.get("git.branch"));
        this.describe           = safeToString(properties.get("git.commit.id.describe"));
        this.commitId           = safeToString(properties.get("git.commit.id"));
        this.commitIdAbbrev     = safeToString(properties.get("git.commit.id.abbrev"));
        this.buildUserName      = safeToString(properties.get("git.build.user.name"));
        this.buildUserEmail     = safeToString(properties.get("git.build.user.email"));
        this.buildTime          = safeToString(properties.get("git.build.time"));
        this.commitUserName     = safeToString(properties.get("git.commit.user.name"));
        this.commitUserEmail    = safeToString(properties.get("git.commit.user.email"));
        this.commitMessageShort = safeToString(properties.get("git.commit.message.short"));
        this.commitMessageFull  = safeToString(properties.get("git.commit.message.full"));
        this.commitTime         = safeToString(properties.get("git.commit.time"));
        this.remoteOriginUrl    = safeToString(properties.get("git.remote.origin.url"));
        // @formatter:on
    }
    
    @Override
    public String toString() {
        // @formatter:off
        return "GitRepositoryState ["      +
                 "\n\tbranch="             + branch             +
                 "\n\tdescribe="           + describe           +
                 "\n\tcommitId="           + commitId           +
                 "\n\tcommitIdAbbrev="     + commitIdAbbrev     +
                 "\n\tbuildUserName="      + buildUserName      +
                 "\n\tbuildUserEmail="     + buildUserEmail     +
                 "\n\tbuildTime="          + buildTime          +
                 "\n\tcommitUserName="     + commitUserName     +
                 "\n\tcommitUserEmail="    + commitUserEmail    +
                 "\n\tcommitMessageFull="  + commitMessageFull  +
                 "\n\tcommitMessageShort=" + commitMessageShort +
                 "\n\tcommitTime="         + commitTime         +
                "\n]";
        // @formatter:on
    }
    
    public String getBranch() {
        return branch;
    }
    
    public String getCommitIdDescribe() {
        return describe;
    }
    
    public String getCommitId() {
        return commitId;
    }
    
    public String getCommitIdAbbrev() {
        return commitIdAbbrev;
    }
    
    public String getBuildUserName() {
        return buildUserName;
    }
    
    public String getBuildUserEmail() {
        return buildUserEmail;
    }
    
    public String getBuildTime() {
        return buildTime;
    }
    
    public String getCommitUserName() {
        return commitUserName;
    }
    
    public String getCommitUserEmail() {
        return commitUserEmail;
    }
    
    public String getCommitMessageFull() {
        return commitMessageFull;
    }
    
    public String getCommitMessageShort() {
        return commitMessageShort;
    }
    
    public String getCommitTime() {
        return commitTime;
    }

    public String getRemoteOrigin() {
        return remoteOriginUrl;
    }
    
}
