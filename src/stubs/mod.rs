//! Stubs for dioxus-motion (disabled for dioxus 0.7 upgrade)
pub mod motion {
    pub struct AnimationMode;
    pub struct AnimationConfig;
    pub struct Tween;
    pub struct Transform { pub x: f64, pub y: f64, pub scale: f64, pub rotate: f64, pub opacity: f64 }
    pub struct Spring;
    pub struct AnimationSequence;
    impl AnimationConfig {
        pub fn new(_: AnimationMode) -> Self { Self }
        pub fn with_duration(self, _: u64) -> Self { self }
    }
    impl AnimationMode { pub fn tween(_: Tween) -> Self { Self } pub fn spring(_: Spring) -> Self { Self } }
    impl Tween { pub fn new(_: u64) -> Self { Self } }
    impl Spring { pub fn new(_: f64, _: f64) -> Self { Self } }
    impl Transform {
        pub fn new() -> Self { Self { x: 0.0, y: 0.0, scale: 1.0, rotate: 0.0, opacity: 1.0 } }
        pub fn identity() -> Self { Self::new() }
        pub fn with_scale(mut self, s: f64) -> Self { self.scale = s; self }
        pub fn with_opacity(mut self, o: f64) -> Self { self.opacity = o; self }
        pub fn with_rotation(mut self, r: f64) -> Self { self.rotate = r; self }
        pub fn with_x(mut self, x: f64) -> Self { self.x = x; self }
        pub fn with_y(mut self, y: f64) -> Self { self.y = y; self }
    }
    impl AnimationSequence {
        pub fn new() -> Self { Self }
        pub fn add_step(self, _: Transform, _: AnimationConfig) -> Self { self }
    }
    pub fn use_motion(_: Transform) -> MotionHandle { MotionHandle }
    pub struct MotionHandle;
    impl MotionHandle {
        pub fn get_value(&self) -> Transform { Transform::new() }
        pub fn animate_to(&self, _: Transform, _: AnimationConfig) {}
        pub fn play_sequence(&self, _: AnimationSequence) {}
    }
}
