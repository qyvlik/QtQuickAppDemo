.import QtQuick 2.0 as QQ2InJS

var component;
var meshObj;
var meshURL;

function createGenericMesh(source) {
    meshURL = source;
    console.log("Loading mesh: " + meshURL)
    component = Qt.createComponent(Qt.resolvedUrl("./GenericMesh.qml"));
    if (component.status === QQ2InJS.Component.Ready)
        finishCreation();
    else
        component.statusChanged.connect(finishCreation);
}

function createCubeMesh() {
    component = Qt.createComponent(Qt.resolvedUrl("./CubeMesh.qml"));
    if (component.status === QQ2InJS.Component.Ready)
        finishCreation();
    else
        component.statusChanged.connect(finishCreation);
}

function createSpotLight() {
    var slComponent = Qt.createComponent(Qt.resolvedUrl("./StaticSpotLight.qml"));
    if (slComponent.status === QQ2InJS.Component.Ready) {
        var slObject = slComponent.createObject(sceneEntity, { "position": Qt.vector3d(5, -2, 0 ), "lightColor": "blue", "sceneEffect": sceneMaterialEffect });
        if (slObject ===  null) {
            // Error Handling
            console.log("Error creating light object");
        }
        else
        {
            // add the newly created light to the ShaderData uniform block
            sceneFinalEffect.spotLightsSD.append(slObject.light)

            var rtComponent = Qt.createComponent(Qt.resolvedUrl("./SpotLightShadowRenderTarget.qml"));
            if (rtComponent.status === QQ2InJS.Component.Ready) {
                var rtObj = rtComponent.createObject(framegraph.shadowsLayer, { "lightCamera": slObject.lightCamera });
                if (rtObj ===  null) {
                    console.log("Error creating render target object");
                }
            }
            else if (rtComponent.status === QQ2InJS.Component.Error) {
                console.log("Error loading component:", slComponent.errorString());
            }
        }
    } else if (slComponent.status === QQ2InJS.Component.Error) {
        // Error Handling
        console.log("Error loading component:", slComponent.errorString());
    }
}

function checkComponent() {
    if (component.status === QQ2InJS.Component.Ready)
        finishCreation();
    else
        component.statusChanged.connect(finishCreation);
}

function finishCreation() {
    if (component.status === QQ2InJS.Component.Ready)
    {
        meshObj = component.createObject(sceneEntity, { "sourceMesh": meshURL, "position": Qt.vector3d(5, -2, 0 ), "sceneEffect": sceneMaterialEffect });
        if (meshObj ===  null)
        {
            // Error Handling
            console.log("Error creating mesh object");
        }
        else
            meshObj.parent = sceneEntity
    } else if (component.status === QQ2InJS.Component.Error) {
        // Error Handling
        console.log("Error loading component:", component.errorString());
    }
}


