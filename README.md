# Centralized Helm chart repository

This repository contains the documentation and resources necessary to build the structure of the application chart templates and objects in namespaces using ACR - OCI Artifacts as a repository.

## Application and namespace chart template <a name="Application and namespace chart template"></a>

Initially we have two folders, one for the application and the other for the namespace where we have the necessary templates with the required values ​​at the architecture, security and compliance level. Each one also has Chart.yaml files where the name of the template and the version to be published are indicated each time a change is made.

The repository has a pipeline where both the application and the namespace are packaged and pushed to the OCI - ACC artifacts in Azure with the latest version indicated in Chart.yaml.

## Namespace chart deployment  <a name="Namespace chart deployment"></a>

The recommendation is to use the infrastructure repository to create the namespace chart deployment pipeline.

We have to deploy our namespace template as it will create policies or any kubernetes object that is transversal to the namespace.

In this creation we call the latest version of the namespace chart and we will be able to define in a value-dev.yaml file the specific namespace and if, for example, we require inbound network policies, or any other type of object that is at the level of the namespace.

```
    - name: Namespace Helm chart package
      run: |
            helm package helm/namespace -d helm/namespace/charts/

    - name: Namespace Azure Container Registry - OCI
      run: |
            helm push $(ls -t helm/namespace/charts/*.tgz | head -n1) oci://${{ vars.REGISTRY_NAME }}.azurecr.io/helm
```

## Application chart by application <a name="Application chart by application"></a>

In each application repository we will only use a folder called helm with the different values.yaml per environment (values-dev.yaml, values-stg.yaml, etc.) and a CI-CD pipeline where we will implement the application graph in AKS using the latest version and customizing it according to our values-ENV.yaml.

```
      - name: Application Helm charts packages
        env:
          TAG: ${{needs.build.outputs.image_tag}}
        run: |
          helm upgrade --install ${{env.APPLICATION_NAME}} oci://${{ vars.REGISTRY_NAME }}.azurecr.io/helm/app-template \
          --namespace=ns-${{env.BU}}-${{ inputs.Environment }}-${{env.APPLICATION_NAME}} \
          --values helm/values-${{ inputs.Environment }}.yaml \
          --set image=${{ vars.REGISTRY_NAME }}.azurecr.io/ns-${{env.BU}}-${{ inputs.Environment }}-${{env.APPLICATION_NAME}}:${{ env.TAG }} \
          --version 0.2.0 --debug --atomic
```

## NOTE <a name="NOTE"></a>

Regular Updates: Keep your application/namespace charts templates up to date with the latest architecture, security and compliance guidelines.
Access Policies: Limit access to your Centralized Helm chart repository to only authorized users and services.