podTemplate(yaml:  """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: docker
    image: docker:latest
    command: ['cat']
    tty: true
    volumeMounts:
    - name: dockersock
      mountPath: /var/run/docker.sock
  nodeSelector:
    kubernetes.io/arch: arm64
  volumes:
  - name: dockersock
    hostPath:
      path: /var/run/docker.sock
 """
 ) {
  node(POD_LABEL) {
    def CONTAINER_REGISTRY = "docker.local.pw10n.pw"
    def CONTAINER_NAME = "keybase"

    def arch = "arm64"
    def imageName = "$CONTAINER_REGISTRY/$CONTAINER_NAME" 
    def imageVersionTag = "$imageName:$BUILD_NUMBER-$arch"


    stage("checkout") {
      checkout scm
    }

    def image
    
    stage("build image") {
      container('docker'){
        image = docker.build(imageVersionTag)
      }
    }

    if (env.BRANCH_NAME == "main"){
      stage("push image") {
        container('docker'){
          image.push()
        }
      }
    }
  }
}