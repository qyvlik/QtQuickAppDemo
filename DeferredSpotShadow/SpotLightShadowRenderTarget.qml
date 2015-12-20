import Qt3D 2.0
import Qt3D.Renderer 2.0

RenderTargetSelector {
    id : lightTargetSelector

    property alias lightCamera: lightCameraSelector.camera
    readonly property Texture2D shadowTexture: depthTexture

    target: RenderTarget {
            attachments: [
                RenderAttachment {
                    name: "depth"
                    type: RenderAttachment.DepthAttachment
                    texture: Texture2D {
                        id: depthTexture
                        width: 1024
                        height: 1024
                        format: Texture.DepthFormat
                        generateMipMaps: false
                        magnificationFilter: Texture.Linear
                        minificationFilter: Texture.Linear
                        wrapMode {
                            x: WrapMode.ClampToEdge
                            y: WrapMode.ClampToEdge
                        }
                        comparisonFunction: Texture.CompareLessEqual
                        comparisonMode: Texture.CompareRefToTexture
                    }
                }
            ]
        }

    ClearBuffer {
        buffers: ClearBuffer.DepthBuffer

        RenderPassFilter {
            id : shadowPass
            includes: [ Annotation { name: "pass"; value: "shadowmap" } ]

            CameraSelector {
                id : lightCameraSelector
            }
        }
    }
}
