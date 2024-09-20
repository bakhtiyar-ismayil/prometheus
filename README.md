# Prometheus Monitoring Setup

This repository contains configurations and scripts for setting up and managing Prometheus, a powerful open-source monitoring and alerting toolkit designed for reliability and scalability. Prometheus is widely used in cloud-native environments for monitoring applications, systems, and services.

## Table of Contents

- [Overview](#overview)
- [Repository Structure](#repository-structure)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
  - [Using Docker](#using-docker)
  - [Manual Installation](#manual-installation)
- [Configuration](#configuration)
  - [Prometheus Configuration File](#prometheus-configuration-file)
  - [Service Discovery](#service-discovery)
- [Starting Prometheus](#starting-prometheus)
- [Using Prometheus](#using-prometheus)
  - [Web Interface](#web-interface)
  - [Querying Metrics](#querying-metrics)
  - [Alerting](#alerting)
- [Grafana Integration](#grafana-integration)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgements](#acknowledgements)

## Overview

Prometheus collects metrics from configured targets at specified intervals, evaluates rule expressions, and can trigger alerts when certain conditions are met. It uses a time-series database with its own data model and provides a powerful query language (PromQL) for extracting and processing data.

## Repository Structure

```
prometheus/
│
├── prometheus.yml           # Main configuration file for Prometheus
├── alert.rules.yml          # Alerting rules configuration
├── scrape_configs/          # Directory for scrape configuration files
├── docker-compose.yml       # Optional: Docker Compose file for easy setup
└── scripts/                 # Scripts for automation and management
```

## Prerequisites

- A Linux-based system (e.g., Ubuntu, CentOS)
- Docker (optional, for containerized deployments)
- Basic knowledge of Linux commands and YAML syntax
- Access to the internet to download Prometheus binaries or Docker images

## Installation

### Using Docker

If you're using Docker, you can quickly set up Prometheus with the following steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/bakhtiyar-ismayil/prometheus.git
   cd prometheus
   ```

2. Start Prometheus with Docker:

   ```bash
   docker run -d \
     -p 9090:9090 \
     --name prometheus \
     -v $(pwd)/prometheus.yml:/etc/prometheus/prometheus.yml \
     prom/prometheus
   ```

### Manual Installation

If you prefer to install Prometheus manually, follow these steps:

1. Download Prometheus:

   ```bash
   wget https://github.com/prometheus/prometheus/releases/download/v2.30.0/prometheus-2.30.0.linux-amd64.tar.gz
   tar xvfz prometheus-2.30.0.linux-amd64.tar.gz
   cd prometheus-2.30.0.linux-amd64
   ```

2. Configure Prometheus by editing the `prometheus.yml` file as needed.

## Configuration

### Prometheus Configuration File

The main configuration file for Prometheus is `prometheus.yml`. Here’s an example of a simple configuration:

```yaml
global:
  scrape_interval: 15s # Set the default scrape interval to 15 seconds

scrape_configs:
  - job_name: 'prometheus' # A job name
    static_configs:
      - targets: ['localhost:9090'] # Target to scrape
```

### Service Discovery

Prometheus supports various service discovery mechanisms, including:

- **Static Configurations**: Manually define targets in the configuration file.
- **DNS SRV Records**: Automatically discover services via DNS.
- **Kubernetes**: Automatically discover services and pods running in a Kubernetes cluster.

Refer to the [Prometheus documentation](https://prometheus.io/docs/prometheus/latest/configuration/configuration/) for more details on service discovery options.

## Starting Prometheus

After configuring Prometheus, start it with the following command:

```bash
./prometheus --config.file=prometheus.yml
```

Prometheus will run on `http://localhost:9090` by default.

## Using Prometheus

### Web Interface

Access the Prometheus web interface by navigating to `http://localhost:9090` in your web browser. The interface provides access to metrics, query functionality, and the status of targets.

### Querying Metrics

Prometheus uses a powerful query language called PromQL. For example, to query the CPU usage of all instances:

```promql
rate(cpu_usage_seconds_total[5m])
```

Refer to the [PromQL documentation](https://prometheus.io/docs/prometheus/latest/querying/basics/) for more query examples.

### Alerting

Prometheus supports alerting rules defined in configuration files. An example alerting rule:

```yaml
groups:
  - name: example_alert
    rules:
      - alert: HighCPUUsage
        expr: sum(rate(cpu_usage_seconds_total[5m])) by (instance) > 0.75
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "High CPU usage detected"
          description: "CPU usage is above 75% for more than 5 minutes."
```

## Grafana Integration

Prometheus integrates seamlessly with Grafana for visualizing metrics. To set it up:

1. Install Grafana (follow the [official installation guide](https://grafana.com/docs/grafana/latest/installation/)).
2. Add Prometheus as a data source in Grafana by specifying the URL `http://localhost:9090`.
3. Create dashboards to visualize your metrics.


## Acknowledgements

- [Prometheus Documentation](https://prometheus.io/docs/)
- [Cloud Native Computing Foundation (CNCF)](https://www.cncf.io/)
```

