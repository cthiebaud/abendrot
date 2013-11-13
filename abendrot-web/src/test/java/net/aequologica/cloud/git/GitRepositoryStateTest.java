package net.aequologica.cloud.git;

import static org.junit.Assert.*;

import java.util.Properties;

import org.junit.Test;

public class GitRepositoryStateTest {
    
    @Test
    public void test() {
        Properties properties = new Properties();
        // @formatter:off
        properties.put("git.branch"                    , "git.branch"                );
        properties.put("git.build.time"                , "git.build.time"            );
        properties.put("git.build.user.email"          , "git.build.user.email"      );
        properties.put("git.build.user.name"           , "git.build.user.name"       );
        properties.put("git.commit.id"                 , "git.commit.id"             );
        properties.put("git.commit.id.abbrev"          , "git.commit.id.abbrev"      );
        properties.put("git.commit.id.describe"        , "git.commit.id.describe"    );
        properties.put("git.commit.message.full"       , "git.commit.message.full"   );
        properties.put("git.commit.message.short"      , "git.commit.message.short"  );
        properties.put("git.commit.time"               , "git.commit.time"           );
        properties.put("git.commit.user.email"         , "git.commit.user.email"     );
        properties.put("git.commit.user.name"          , "git.commit.user.name"      );
        // @formatter:on
        
        GitRepositoryState gitRepositoryState = new GitRepositoryState(properties);
        
        // @formatter:off
        assertEquals(gitRepositoryState.getBranch()             , "git.branch"               );
        assertEquals(gitRepositoryState.getBuildTime()          , "git.build.time"           );
        assertEquals(gitRepositoryState.getBuildUserEmail()     , "git.build.user.email"     );
        assertEquals(gitRepositoryState.getBuildUserName()      , "git.build.user.name"      );
        assertEquals(gitRepositoryState.getCommitId()           , "git.commit.id"            );
        assertEquals(gitRepositoryState.getCommitIdAbbrev()     , "git.commit.id.abbrev"     );
        assertEquals(gitRepositoryState.getCommitIdDescribe()   , "git.commit.id.describe"   );
        assertEquals(gitRepositoryState.getCommitMessageFull()  , "git.commit.message.full"  );
        assertEquals(gitRepositoryState.getCommitMessageShort() , "git.commit.message.short" );
        assertEquals(gitRepositoryState.getCommitTime()         , "git.commit.time"          );
        assertEquals(gitRepositoryState.getCommitUserEmail()    , "git.commit.user.email"    );
        assertEquals(gitRepositoryState.getCommitUserName()     , "git.commit.user.name"     );
        // @formatter:on
    }
    
}
