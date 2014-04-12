//
//  CCMyScene.m
//  Space Cannon
//
//  Created by Presentation on 10/02/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "CCMyScene.h"

@implementation CCMyScene
{
    SKNode *_mainLayer;
    SKSpriteNode *_cannon;
    SKSpriteNode *_ammoDisplay;
    BOOL _didShoot;
}

static const CGFloat kCCShootSpeed = 1000.0;
static const CGFloat kCCHaloLowAngle = 200.0 * M_PI / 180.0;
static const CGFloat kCCHaloHighAngle = 340.0 * M_PI / 180.0;
static const CGFloat kCCHaloSpeed = 100.0;

static const uint32_t kCCHaloCategory    = 0x1 << 0;
static const uint32_t kCCBallCategory    = 0x1 << 1;
static const uint32_t kCCEdgeCategory    = 0x1 << 2;
static const uint32_t kCCShieldCategory  = 0x1 << 3;
static const uint32_t kCCLifeBarCategory = 0x1 << 4;

static inline CGVector radiansToVector(CGFloat radians)
{
    CGVector vector;
    vector.dx = cosf(radians);
    vector.dy = sinf(radians);
    return vector;
}

static inline CGFloat randomInRange(CGFloat low, CGFloat high)
{
    CGFloat value = arc4random_uniform(UINT32_MAX) / (CGFloat)UINT32_MAX;
    return value * (high - low) + low;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        // Turn off gravity.
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0);
        self.physicsWorld.contactDelegate = self;
        
        // Add background.
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"Starfield"];
        background.position = CGPointZero;
        background.anchorPoint = CGPointZero;
        background.blendMode = SKBlendModeReplace;
        [self addChild:background];
        
        // Add edges.
        SKNode *leftEdge = [[SKNode alloc] init];
        leftEdge.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointZero toPoint:CGPointMake(0.0, self.size.height)];
        leftEdge.position = CGPointZero;
        leftEdge.physicsBody.categoryBitMask = kCCEdgeCategory;
        [self addChild:leftEdge];
        
        SKNode *rightEdge = [[SKNode alloc] init];
        rightEdge.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointZero toPoint:CGPointMake(0.0, self.size.height)];
        rightEdge.position = CGPointMake(self.size.width, 0.0);
        rightEdge.physicsBody.categoryBitMask = kCCEdgeCategory;
        [self addChild:rightEdge];
        
        
        // Add main layer.
        _mainLayer = [[SKNode alloc] init];
        [self addChild:_mainLayer];
        
        // Add cannon.
        _cannon = [SKSpriteNode spriteNodeWithImageNamed:@"Cannon"];
        _cannon.position = CGPointMake(self.size.width * 0.5, 0.0);
        [_mainLayer addChild:_cannon];
        
        // Create cannon rotation actions.
        SKAction *rotateCannon = [SKAction sequence:@[[SKAction rotateByAngle:M_PI duration:2],
                                                      [SKAction rotateByAngle:-M_PI duration:2]]];
        [_cannon runAction:[SKAction repeatActionForever:rotateCannon]];
        
        // Create spawn halo actions.
        SKAction *spawnHalo = [SKAction sequence:@[[SKAction waitForDuration:2 withRange:1],
                                                   [SKAction performSelector:@selector(spawnHalo) onTarget:self]]];
        [self runAction:[SKAction repeatActionForever:spawnHalo]];
        
        // Setup Ammo.
        _ammoDisplay = [SKSpriteNode spriteNodeWithImageNamed:@"Ammo5"];
        _ammoDisplay.anchorPoint = CGPointMake(0.5, 0.0);
        _ammoDisplay.position = _cannon.position;
        [_mainLayer addChild:_ammoDisplay];
        self.ammo = 5;
        
        SKAction *incrementAmmo = [SKAction sequence:@[[SKAction waitForDuration:1],
                                                       [SKAction runBlock:^{
            self.ammo++;
        }]]];
        [self runAction:[SKAction repeatActionForever:incrementAmmo]];
        
        // Setup shields
        for (int i = 0; i < 6; i++) {
            SKSpriteNode *shield = [SKSpriteNode spriteNodeWithImageNamed:@"Block"];
            shield.position = CGPointMake(35 + (50 *i), 90);
            [_mainLayer addChild:shield];
            shield.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(42, 9)];
            shield.physicsBody.categoryBitMask = kCCShieldCategory;
            shield.physicsBody.collisionBitMask = 0;
        }
        
        SKSpriteNode *lifeBar = [SKSpriteNode spriteNodeWithImageNamed:@"BlueBar"];
        lifeBar.position = CGPointMake(self.size.width * 0.5, 70);
        lifeBar.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(-lifeBar.size.width * 0.5, 0) toPoint:CGPointMake(lifeBar.size.width * 0.5, 0)];
        lifeBar.physicsBody.categoryBitMask = kCCLifeBarCategory;
        [_mainLayer addChild:lifeBar];
        
        
    }
    return self;
}

-(void)setAmmo:(int)ammo
{
    if (ammo >= 0 && ammo <= 5) {
        _ammo = ammo;
        _ammoDisplay.texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"Ammo%d", ammo]];
    }
}


-(void)shoot
{
    if (self.ammo > 0) {
        self.ammo--;
    
        // Create ball node.
        SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"Ball"];
        ball.name = @"ball";
        CGVector rotationVector = radiansToVector(_cannon.zRotation);
        ball.position = CGPointMake(_cannon.position.x + (_cannon.size.width * 0.5 * rotationVector.dx),
                                    _cannon.position.y + (_cannon.size.width * 0.5 * rotationVector.dy));
        [_mainLayer addChild:ball];
        
        ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:6.0];
        ball.physicsBody.velocity = CGVectorMake(rotationVector.dx * kCCShootSpeed, rotationVector.dy * kCCShootSpeed);
        ball.physicsBody.restitution = 1.0;
        ball.physicsBody.linearDamping = 0.0;
        ball.physicsBody.friction = 0.0;
        ball.physicsBody.categoryBitMask = kCCBallCategory;
        ball.physicsBody.collisionBitMask = kCCEdgeCategory;
    }
    
}

-(void)spawnHalo
{
    // Create halo node.
    SKSpriteNode *halo = [SKSpriteNode spriteNodeWithImageNamed:@"Halo"];
    halo.position = CGPointMake(randomInRange(halo.size.width * 0.5, self.size.width - (halo.size.width * 0.5)),
                                self.size.height + (halo.size.height * 0.5));
    halo.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:16.0];
    CGVector direction = radiansToVector(randomInRange(kCCHaloLowAngle, kCCHaloHighAngle));
    halo.physicsBody.velocity = CGVectorMake(direction.dx * kCCHaloSpeed, direction.dy * kCCHaloSpeed);
    halo.physicsBody.restitution = 1.0;
    halo.physicsBody.linearDamping = 0.0;
    halo.physicsBody.friction = 0.0;
    halo.physicsBody.categoryBitMask = kCCHaloCategory;
    halo.physicsBody.collisionBitMask = kCCEdgeCategory;
    halo.physicsBody.contactTestBitMask = kCCBallCategory | kCCShieldCategory |kCCLifeBarCategory;
    [_mainLayer addChild:halo];
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody;
    SKPhysicsBody *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (firstBody.categoryBitMask == kCCHaloCategory && secondBody.categoryBitMask == kCCBallCategory) {
        // Collision between halo and ball.
        [self addExplosion:firstBody.node.position withName:@"HaloExplosion"];
        
        [firstBody.node removeFromParent];
        [secondBody.node removeFromParent];
    }
    if (firstBody.categoryBitMask == kCCHaloCategory && secondBody.categoryBitMask == kCCShieldCategory) {
        // Collision between halo and shield.
        [self addExplosion:firstBody.node.position withName:@"HaloExplosion"];
        
        [firstBody.node removeFromParent];
        [secondBody.node removeFromParent];
    }
    if (firstBody.categoryBitMask == kCCHaloCategory && secondBody.categoryBitMask == kCCLifeBarCategory) {
        // Collision between halo and life bar.
        [self addExplosion:firstBody.node.position withName:@"HaloExplosion"];
        [self addExplosion:secondBody.node.position withName:@"LifeBarExplosion"];
        
        [firstBody.node removeFromParent];
        [secondBody.node removeFromParent];
    }
    
}

-(void)addExplosion:(CGPoint)position withName:(NSString*)name
{
    NSString *explosionPath = [[NSBundle mainBundle] pathForResource:name ofType:@"sks"];
    SKEmitterNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:explosionPath];
    
    explosion.position = position;
    [_mainLayer addChild:explosion];
    
    SKAction *removeExplosion = [SKAction sequence:@[[SKAction waitForDuration:1.5],
                                                     [SKAction removeFromParent]]];
    [explosion runAction:removeExplosion];
                                 
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        _didShoot = YES;
    }
}

-(void)didSimulatePhysics
{
    // Shoot.
    if (_didShoot) {
        [self shoot];
        _didShoot = NO;
    }
    
    // Remove unused nodes.
    [_mainLayer enumerateChildNodesWithName:@"ball" usingBlock:^(SKNode *node, BOOL *stop) {
        if (!CGRectContainsPoint(self.frame, node.position)) {
            [node removeFromParent];
        }
    }];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end



