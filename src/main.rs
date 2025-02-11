use kube::{Client, api::Api};
use k8s_openapi::api::core::v1::{Pod, Namespace};
use tokio;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    // Initialize Kubernetes client
    let client = Client::try_default().await?;

    // Access the Namespace API
    let namespaces: Api<Namespace> = Api::all(client.clone());

    // List parameters
    let lp = kube::api::ListParams::default();

    // Get all namespaces
    println!("\nKubernetes Cluster Pod Overview:");
    println!("===============================");
    
    for ns in namespaces.list(&lp).await? {
        let ns_name = ns.metadata.name.unwrap_or_default();
        println!("\nNamespace: {}", ns_name);
        println!("{}","-".repeat(ns_name.len() + 10));

        // Get pods in this namespace
        let pods: Api<Pod> = Api::namespaced(client.clone(), &ns_name);
        
        // List all pods in the namespace
        match pods.list(&lp).await {
            Ok(pod_list) => {
                if pod_list.items.is_empty() {
                    println!("  No pods found");
                } else {
                    for pod in pod_list {
                        let pod_name = pod.metadata.name.unwrap_or_default();
                        let status = pod.status.and_then(|s| s.phase).unwrap_or_default();
                        println!("  Pod: {} (Status: {})", pod_name, status);
                    }
                }
            },
            Err(e) => println!("  Error listing pods: {}", e),
        }
    }

    Ok(())
}
