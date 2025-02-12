# Kubernetes with Rust, MicroK8s, cert-manager, Gateway API, and LocalAI

This repository demonstrates AI-driven Kubernetes clusters managed with [**MicroK8s**](https://microk8s.io/), integrating a [**Rust**](https://www.rust-lang.org/) application that interacts with the Kubernetes API using [**Tokio**](https://tokio.rs/) and the [**kube**](https://kube.rs/) crate. It features modern service networking with the [Gateway API](https://gateway-api.sigs.k8s.io/), TLS certificate management via [**cert-manager**](https://cert-manager.io/), and AI capabilities using [**K8sGPT**](https://k8sgpt.ai/) for cluster analytics, and [**LocalAI**](https://localai.io/) for API-compatible AI model endpoints.

## ⚠️ Development-Only Notice

These local Kubernetes deployments use TLS certificates created by a `selfsigned-issuer`, which are suitable for experimental development only and NOT intended for production use cases. A transition to a production-grade setup would require using [Let's Encrypt](https://letsencrypt.org/) or another trusted certificate authority.

---

## Features

- **Gateway API**: Next-generation service networking with HTTPRoute for granular traffic control and TLS.
- **Cert-Manager**: Automates TLS certificate issuance using a `selfsigned-issuer` for development environments.
- **Rust Application**: A minimal implementation demonstrating [Kubernetes API](https://kubernetes.io/docs/reference/kubernetes-api/) interaction by listing Pods across all namespaces with their statuses, serving as a foundation for building advanced cluster operations such as pod management, resource monitoring, CRD handling, event watching, and multi-cluster management.
- **K8sGPT**: Cluster diagnostics powered by AI.
- **LocalAI**: Self-hosted AI capabilities with persistent storage for models, offering potential for privacy-focused, scalable, and cost-efficient AI model deployment.

## Scalability Benefits

Running Large Language Models (LLMs) on Kubernetes provides unique advantages for scaling AI workloads:

- **Horizontal Pod Autoscaling**: Automatically scale LLM inference endpoints based on demand, ensuring optimal resource utilization and consistent response times even under varying loads. Multiple LocalAI instances can be deployed across nodes to handle increased traffic without service degradation.
- **Resource Optimization**: Leverage Kubernetes' native scheduling and resource management to efficiently distribute AI workloads across the cluster, enabling dynamic allocation of GPU and CPU resources based on model requirements and usage patterns.

## Direction

This project showcases an educational and experimental setup, offering a starting point for advanced use cases. Here are some possibilities:

- **Production-Grade TLS Certificates**: Transition to production-ready deployments by integrating trusted certificate authorities like Let's Encrypt or custom enterprise CAs for secure and scalable HTTPS traffic management.
- **Dynamic Cluster Management**: Automate scaling, monitoring, and resource optimization across multiple clusters.
- **Custom Resource Definitions (CRDs)**: Implement and manage custom Kubernetes resources tailored to specific application requirements.
- **Event-Driven Automation**: Extend the Rust app to respond to Kubernetes events or webhooks for real-time cluster adjustments.
- **AI Workload Orchestration**: Use LocalAI to manage and deploy advanced AI models for edge computing, predictive analytics, or machine learning tasks.
- **Security Enhancements**: Integrate advanced authentication mechanisms and Role-Based Access Control (RBAC) policies for secure multi-user environments.
- **Multi-Tenancy Support**: Enable resource isolation and quota management for multi-tenant Kubernetes clusters.
- **Advanced Networking**: Leverage Gateway API features for traffic splitting, failover mechanisms, and routing policies based on performance metrics.
- **Hybrid Cloud Deployments**: Adapt the setup for hybrid or multi-cloud Kubernetes deployments.
- **Natural Language Processing (NLP)**: Implement AI-powered features such as text summarization, sentiment analysis, or chatbot functionality for applications requiring language understanding.
- **Image and Video Processing**: Use AI models to enable facial recognition, object detection, image classification, or video analytics for multimedia applications.
- **Image and Video Processing**: Use AI models to enable facial recognition, object detection, image classification, or video analytics for multimedia applications.
