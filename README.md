# Kubernetes with Rust, MicroK8s, cert-manager, Gateway API, and LocalAI

This repository demonstrates a [**Kubernetes**](https://kubernetes.io/) cluster managed with [**MicroK8s**](https://microk8s.io/), integrating a [**Rust**](https://www.rust-lang.org/) application that interacts with the Kubernetes API using [**Tokio**](https://tokio.rs/) and the [**kube**](https://kube.rs/) crate. It features modern networking with the [Gateway API](https://gateway-api.sigs.k8s.io/), TLS certificate management via [**cert-manager**](https://cert-manager.io/), and AI capabilities using [**LocalAI**](https://localai.io/). This project is suitable for development and testing purposes, leveraging MicroK8s for a lightweight and efficient Kubernetes environment.

---

## ⚠️ Development-Only Notice

**This application uses a `selfsigned-issuer` for TLS certificates, which is suitable for development but NOT recommended for production.** The self-signed certificates provided by cert-manager are ideal for testing environments; however, they lack the security guarantees required for production use. This repository is NOT intended for production deployments and should not be used as such.

---

## Features

- **Gateway API**: Next-generation service networking with HTTPRoute for granular traffic control and TLS integration.
- **Cert-Manager**: Automates TLS certificate issuance using a self-signed issuer for development.
- **Rust Application**: Interacts with the Kubernetes API to list Pods and can be extended for advanced cluster operations.
- **LocalAI**: Self-hosted AI capabilities with robust potential for privacy-focused, scalable, and cost-efficient AI model deployment.

---

## Getting Started

This repository provides a lightweight platform for exploring Kubernetes features like Gateway API, cert-manager, and LocalAI in a local development environment. Extend the Rust application or experiment with Kubernetes networking and AI capabilities to suit your needs.
