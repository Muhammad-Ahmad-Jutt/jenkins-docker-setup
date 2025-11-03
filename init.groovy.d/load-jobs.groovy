import jenkins.model.*
import hudson.model.*
import java.io.File

println ">>> [INIT] Starting custom job loader script..."

def jenkins = Jenkins.getInstanceOrNull()
if (jenkins == null) {
    println ">>> [INIT] Jenkins instance not ready yet — will retry later."
    return
}

Thread.start {
    sleep(10000) // wait 10 seconds for Jenkins to finish startup
    println ">>> [INIT] Scanning for jobs after delay..."

    def jobsDir = new File(jenkins.getRootDir(), "jobs")
    if (!jobsDir.exists()) {
        println ">>> [INIT] No jobs directory found."
        return
    }

    jobsDir.eachDir { jobDir ->
        def jobName = jobDir.name
        def configFile = new File(jobDir, "config.xml")
        if (configFile.exists()) {
            println ">>> [INIT] Found config.xml for '${jobName}', creating..."
            try {
                def xmlStream = new ByteArrayInputStream(configFile.text.getBytes("UTF-8"))
                def existing = jenkins.getItem(jobName)
                if (existing == null) {
                    jenkins.createProjectFromXML(jobName, xmlStream)
                    println ">>> [INIT] Job '${jobName}' created."
                } else {
                    println ">>> [INIT] Job '${jobName}' already exists, skipping."
                }
            } catch (Exception e) {
                println "!!! [INIT] Error creating job '${jobName}': ${e.message}"
            }
        } else {
            println ">>> [INIT] No config.xml found in '${jobDir.name}'"
        }
    }

    jenkins.reload()
    println ">>> [INIT] Jenkins job loading complete."
}
