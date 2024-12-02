#![allow(non_snake_case)]
use dioxus::prelude::*;
use serde::{Deserialize, Serialize};
use server_fn::codec::{GetUrl, Json};

fn main() {
    println!("server running on http://localhost:8080");
    dioxus::launch(App);
}

fn App() -> Element {
    // Workaround code
    // let data = use_server_future(move || async move {
    //     match reqwest::get("http://localhost:8080/api/data").await {
    //         Ok(res) => res.json::<GetResponse>().await.unwrap_or_default(),
    //         Err(_) => GetResponse::default(),
    //     }
    // });

    // panic code
    let data = use_server_future(move || get_server_data())?;

    rsx! {
        div { "panic test {data:?}" }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, Default)]
pub struct GetResponse {
    data: String,
}

#[server(endpoint = "/data", input=GetUrl, output=Json)]
pub async fn get_server_data() -> Result<GetResponse, ServerFnError> {
    // this awaiting cause hydration panic
    let _ = reqwest::get("https://google.com").await;

    Ok(GetResponse {
        data: "test".to_string(),
    })
}
