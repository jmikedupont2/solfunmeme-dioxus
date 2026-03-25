pub mod app;
pub use app::MenuOption;

// Active playground modules
pub mod bert_test;
pub mod monster_meta_meme;
pub mod performance_charts;
pub mod rust_parser;
pub mod mcp;

// Desktop-only (animations, heavy rendering)
#[cfg(not(target_arch = "wasm32"))]
pub mod solfunmeme;
#[cfg(not(target_arch = "wasm32"))]
pub mod solfunnice;
#[cfg(not(target_arch = "wasm32"))]
pub mod test_emojis;
#[cfg(not(target_arch = "wasm32"))]
pub mod orbits;
pub mod test_components;
