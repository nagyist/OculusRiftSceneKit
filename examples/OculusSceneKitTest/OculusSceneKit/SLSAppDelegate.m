#import "SLSAppDelegate.h"

@implementation SLSAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    SCNScene *scene = [SCNScene scene];
    
    SCNNode *objectsNode = [SCNNode node];
    [scene.rootNode addChildNode:objectsNode];
    
    CGFloat roomRadius = 600.0;

    // Set up the object and wall materials
    SCNMaterial *holodeckWalls = [SCNMaterial material];
    holodeckWalls.diffuse.minificationFilter = SCNLinearFiltering;
    holodeckWalls.diffuse.magnificationFilter = SCNLinearFiltering;
    holodeckWalls.diffuse.mipFilter = SCNLinearFiltering;
    NSImage *diffuseImage = [NSImage imageNamed:@"Holodeck"];
    holodeckWalls.diffuse.contents  = diffuseImage;
    holodeckWalls.specular.contents = [NSColor colorWithDeviceRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    holodeckWalls.shininess = 0.25;

    SCNMaterial *torusReflectiveMaterial = [SCNMaterial material];
    torusReflectiveMaterial.diffuse.contents = [NSColor blueColor];
    torusReflectiveMaterial.specular.contents = [NSColor whiteColor];
    torusReflectiveMaterial.shininess = 100.0;
    
    // Configure the room
    SCNPlane *floor = [SCNPlane planeWithWidth:roomRadius * 2.0 height:roomRadius * 2.0];
    floor.materials = @[holodeckWalls];
    SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
    CATransform3D wallTransform = CATransform3DMakeTranslation(0.0, -roomRadius, 0.0);
    wallTransform = CATransform3DRotate(wallTransform, -M_PI /2.0, 1.0, 0.0, 0.0);
    floorNode.transform = wallTransform;
    [scene.rootNode addChildNode:floorNode];

    SCNPlane *ceiling = [SCNPlane planeWithWidth:roomRadius * 2.0 height:roomRadius * 2.0];
    ceiling.materials = @[holodeckWalls];
    SCNNode *ceilingNode = [SCNNode nodeWithGeometry:ceiling];
    wallTransform = CATransform3DMakeTranslation(0.0, roomRadius, 0.0);
    wallTransform = CATransform3DRotate(wallTransform, M_PI /2.0, 1.0, 0.0, 0.0);
    ceilingNode.transform = wallTransform;
    [scene.rootNode addChildNode:ceilingNode];

    SCNPlane *leftWall = [SCNPlane planeWithWidth:roomRadius * 2.0 height:roomRadius * 2.0];
    leftWall.materials = @[holodeckWalls];
    SCNNode *leftWallNode = [SCNNode nodeWithGeometry:leftWall];
    wallTransform = CATransform3DMakeTranslation(-roomRadius, 0.0, 0.0);
    wallTransform = CATransform3DRotate(wallTransform, M_PI /2.0, 0.0, 1.0, 0.0);
    leftWallNode.transform = wallTransform;
    [scene.rootNode addChildNode:leftWallNode];

    SCNPlane *rightWall = [SCNPlane planeWithWidth:roomRadius * 2.0 height:roomRadius * 2.0];
    rightWall.materials = @[holodeckWalls];
    SCNNode *rightWallNode = [SCNNode nodeWithGeometry:rightWall];
    wallTransform = CATransform3DMakeTranslation(roomRadius, 0.0, 0.0);
    wallTransform = CATransform3DRotate(wallTransform, -M_PI /2.0, 0.0, 1.0, 0.0);
    rightWallNode.transform = wallTransform;
    [scene.rootNode addChildNode:rightWallNode];

    SCNPlane *frontWall = [SCNPlane planeWithWidth:roomRadius * 2.0 height:roomRadius * 2.0];
    frontWall.materials = @[holodeckWalls];
    SCNNode *frontWallNode = [SCNNode nodeWithGeometry:frontWall];
    wallTransform = CATransform3DMakeTranslation(0.0, 0.0, -roomRadius);
    frontWallNode.transform = wallTransform;
    [scene.rootNode addChildNode:frontWallNode];

    SCNPlane *rearWall = [SCNPlane planeWithWidth:roomRadius * 2.0 height:roomRadius * 2.0];
    rearWall.materials = @[holodeckWalls];
    SCNNode *rearWallNode = [SCNNode nodeWithGeometry:rearWall];
    wallTransform = CATransform3DMakeTranslation(0.0, 0.0, roomRadius);
    wallTransform = CATransform3DRotate(wallTransform, -M_PI, 0.0, 1.0, 0.0);
    rearWallNode.transform = wallTransform;
    [scene.rootNode addChildNode:rearWallNode];

    // Throw a few objects into the room
    SCNBox *cube = [SCNBox boxWithWidth:200 height:200 length:200 chamferRadius:0.0];
    SCNNode *cubeNode = [SCNNode nodeWithGeometry:cube];
    cubeNode.position = SCNVector3Make(300, 0, -300);
    [objectsNode addChildNode:cubeNode];
    
    SCNTorus *torus = [SCNTorus torusWithRingRadius:60 pipeRadius:20];
    SCNNode *torusNode = [SCNNode nodeWithGeometry:torus];
    torusNode.position = SCNVector3Make(-50, 0, -100);
    torus.materials = @[torusReflectiveMaterial];
    [objectsNode addChildNode:torusNode];
    
    SCNCylinder *cylinder = [SCNCylinder cylinderWithRadius:40.0 height:100.0];
    SCNNode *cylinderNode = [SCNNode nodeWithGeometry:cylinder];
    cylinderNode.position = SCNVector3Make(-400, -400, -400);
    [objectsNode addChildNode:cylinderNode];

    SCNSphere *sphere = [SCNSphere sphereWithRadius:40.0];
    SCNNode *sphereNode = [SCNNode nodeWithGeometry:sphere];
    sphereNode.position = SCNVector3Make(200, -200, 0);
    [objectsNode addChildNode:sphereNode];

    SCNPyramid *pyramid = [SCNPyramid pyramidWithWidth:60 height:60 length:60];
    SCNNode *pyramidNode = [SCNNode nodeWithGeometry:pyramid];
    pyramidNode.position = SCNVector3Make(200, 200, -200);
    [objectsNode addChildNode:pyramidNode];
    
    // Create ambient light
    SCNLight *ambientLight = [SCNLight light];
	SCNNode *ambientLightNode = [SCNNode node];
    ambientLight.type = SCNLightTypeAmbient;
	ambientLight.color = [NSColor colorWithDeviceWhite:0.1 alpha:1.0];
	ambientLightNode.light = ambientLight;
    [scene.rootNode addChildNode:ambientLightNode];
    
    // Create a diffuse light
	SCNLight *diffuseLight = [SCNLight light];
    SCNNode *diffuseLightNode = [SCNNode node];
    diffuseLight.type = SCNLightTypeOmni;
    diffuseLightNode.light = diffuseLight;
	diffuseLightNode.position = SCNVector3Make(0, 300, 0);
	[scene.rootNode addChildNode:diffuseLightNode];

    // Animate the objects
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:CATransform3DRotate(torusNode.transform, 0 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(torusNode.transform, 1 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(torusNode.transform, 2 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(torusNode.transform, 3 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(torusNode.transform, 4 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        nil];
    animation.duration = 3.f;
    animation.repeatCount = HUGE_VALF;

    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation2.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:CATransform3DRotate(cubeNode.transform, 0 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(cubeNode.transform, 1 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(cubeNode.transform, 2 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(cubeNode.transform, 3 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(cubeNode.transform, 4 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        nil];
    animation2.duration = 7.f;
    animation2.repeatCount = HUGE_VALF;

    
    [torusNode addAnimation:animation forKey:@"transform"];
    [cubeNode addAnimation:animation2 forKey:@"transform"];

    NSLog(@"Oculus view: %@", self.oculusView);
    self.oculusView.scene = scene;
    
    // Have this start in fullscreen so that the rendering matches up to the Oculus Rift
    [self.window toggleFullScreen:nil];
}


- (IBAction)increaseIPD:(id)sender;
{
    self.oculusView.interpupillaryDistance = self.oculusView.interpupillaryDistance + 2.0;
}

- (IBAction)decreaseIPD:(id)sender;
{
    self.oculusView.interpupillaryDistance = self.oculusView.interpupillaryDistance - 2.0;
}

- (IBAction)increaseDistance:(id)sender;
{
    SCNVector3 currentLocation = self.oculusView.headLocation;
    currentLocation.z = currentLocation.z - 50.0;
    self.oculusView.headLocation = currentLocation;
}

- (IBAction)decreaseDistance:(id)sender;
{
    SCNVector3 currentLocation = self.oculusView.headLocation;
    currentLocation.z = currentLocation.z + 50.0;
    self.oculusView.headLocation = currentLocation;
}

@end
