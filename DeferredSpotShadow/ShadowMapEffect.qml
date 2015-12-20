import Qt3D 2.0
import Qt3D.Renderer 2.0

Effect {
    id : shmEffect
    techniques : [
        // OpenGL 3.1
        Technique {
            openGLFilter {
                api : OpenGLFilter.Desktop
                profile : OpenGLFilter.Core
                majorVersion : 3
                minorVersion : 2
            }

            renderPasses : RenderPass {
                annotations : Annotation { name : "pass"; value : "shadowmap" }
                shaderProgram : ShaderProgram {
                    id : sceneShaderGL3
                    vertexShaderCode:
                        "#version 150 core

                        in vec3 vertexPosition;

                        uniform mat4 mvp;

                        void main()
                        {
                            gl_Position = mvp * vec4(vertexPosition, 1.0);
                        }"
                    fragmentShaderCode:
                        "#version 150 core

                        void main()
                        {
                        }"
                    }
            }
        }
    ]
}
