use kube::{Client, api::Api};
use k8s_openapi::api::core::v1::Pod;
use tokio;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    // Initialize Kubernetes client
    let client = Client::try_default().await?;

    // Access the Pod API in the "default" namespace
    let pods: Api<Pod> = Api::namespaced(client, "default");

    // List all Pods
    let lp = kube::api::ListParams::default();
    for pod in pods.list(&lp).await? {
        println!("Found Pod: {}", pod.metadata.name.unwrap_or_default());
    }

    Ok(())
}
