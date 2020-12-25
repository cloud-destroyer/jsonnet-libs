
{
  local k =
    (import 'k.libsonnet'),

  local deployment = k.apps.v1.deployment,
  local container = k.core.v1.container,

  expandContainerEnvironment(containerNames, envMap): {
    deployment+:
      deployment.mapContainersWithName(
        containerNames,
        function(c) c + container.withEnvMap(envMap)
      ),
  },

  /*
  expandInitContainerEnvironment(containerNames, envMap): {
    deployment+:
      deployment.mapInitContainersWithName(
        containerNames,
        function(c) c + container.withEnvMap(envMap)
      ),
  },
  */
}