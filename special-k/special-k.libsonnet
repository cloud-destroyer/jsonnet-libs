local k = import 'ksonnet-util/kausal.libsonnet';
local fn = {
  mapInitContainers(f):: {
    local podContainers = super.spec.template.spec.initContainers,
    spec+: {
      template+: {
        spec+: {
          initContainers: std.map(f, podContainers),
        },
      },
    },
  },
  mapInitContainersWithName(names, f)::
    local nameSet = if std.type(names) == 'array' then std.set(names) else std.set([names]);
    local inNameSet(name) = std.length(std.setInter(nameSet, std.set([name]))) > 0;

    self.mapInitContainers(function(c) if std.objectHas(c, 'name') && inNameSet(c.name) then f(c) else c),
};

k + {
  apps:: k.apps + {
    v1:: k.apps.v1 + {
      daemonSet:: k.apps.v1.daemonSet + {
        mapInitContainers(f):: fn.mapInitContainers(f),
        mapInitContainersWithName(names, f):: fn.mapInitContainersWithName(names, f),
      },
      deployment:: k.apps.v1.deployment + {
        mapInitContainers(f):: fn.mapInitContainers(f),
        mapInitContainersWithName(names, f):: fn.mapInitContainersWithName(names, f),
      },
      replicaSet:: k.apps.v1.replicaSet + {
        mapInitContainers(f):: fn.mapInitContainers(f),
        mapInitContainersWithName(names, f):: fn.mapInitContainersWithName(names, f),
      },
      statefulSet:: k.apps.v1.statefulSet + {
        mapInitContainers(f):: fn.mapInitContainers(f),
        mapInitContainersWithName(names, f):: fn.mapInitContainersWithName(names, f),
      },
    },
    v1beta1:: k.apps.v1beta1 + {
      deployment:: k.apps.v1beta1.deployment + {
        mapInitContainers(f):: fn.mapInitContainers(f),
        mapInitContainersWithName(names, f):: fn.mapInitContainersWithName(names, f),
      },
      statefulSet:: k.apps.v1beta1.statefulSet + {
        mapInitContainers(f):: fn.mapInitContainers(f),
        mapInitContainersWithName(names, f):: fn.mapInitContainersWithName(names, f),
      },
    },
    v1beta2:: k.apps.v1beta2 + {
      daemonSet:: k.apps.v1beta2.daemonSet + {
        mapInitContainers(f):: fn.mapInitContainers(f),
        mapInitContainersWithName(names, f):: fn.mapInitContainersWithName(names, f),
      },
      deployment:: k.apps.v1beta2.deployment + {
        mapInitContainers(f):: fn.mapInitContainers(f),
        mapInitContainersWithName(names, f):: fn.mapInitContainersWithName(names, f),
      },
      replicaSet:: k.apps.v1beta2.replicaSet + {
        mapInitContainers(f):: fn.mapInitContainers(f),
        mapInitContainersWithName(names, f):: fn.mapInitContainersWithName(names, f),
      },
      statefulSet:: k.apps.v1beta2.statefulSet + {
        mapInitContainers(f):: fn.mapInitContainers(f),
        mapInitContainersWithName(names, f):: fn.mapInitContainersWithName(names, f),
      },
    },
  },
  batch:: k.batch + {
    v1:: k.batch.v1 + {
      job:: k.batch.v1.job + {
        mapInitContainers(f):: fn.mapInitContainers(f),
        mapInitContainersWithName(names, f):: fn.mapInitContainersWithName(names, f),
      },
    },
    v1beta1:: k.batch.v1beta1 + {
      cronJob:: k.batch.v1beta1.cronJob + {
        mapInitContainers(f):: fn.mapInitContainers(f),
        mapInitContainersWithName(names, f):: fn.mapInitContainersWithName(names, f),
      },
    },
  },
  core:: k.core + {
    v1:: k.core.v1 + {
      list:: {
        new(items):: {
          apiVersion: 'v1',
        } + {
          kind: 'List',
        } + self.items(items),
        items(items):: if std.type(items) == 'array' then { items+: items } else { items+: [items] },
      },
      pod:: k.core.v1.pod + {
        mapInitContainers(f):: fn.mapInitContainers(f),
        mapInitContainersWithName(names, f):: fn.mapInitContainersWithName(names, f),
      },
      podTemplate:: k.core.v1.podTemplate + {
        mapInitContainers(f):: fn.mapInitContainers(f),
        mapInitContainersWithName(names, f):: fn.mapInitContainersWithName(names, f),
      },
      replicationController:: k.core.v1.replicationController + {
        mapInitContainers(f):: fn.mapInitContainers(f),
        mapInitContainersWithName(names, f):: fn.mapInitContainersWithName(names, f),
      },
    },
  },
  extensions:: k.extensions + {
    v1beta1:: k.extensions.v1beta1 + {
      daemonSet:: k.extensions.v1beta1.daemonSet + {
        mapInitContainers(f):: fn.mapInitContainers(f),
        mapInitContainersWithName(names, f):: fn.mapInitContainersWithName(names, f),
      },
      deployment:: k.extensions.v1beta1.deployment + {
        mapInitContainers(f):: fn.mapInitContainers(f),
        mapInitContainersWithName(names, f):: fn.mapInitContainersWithName(names, f),
      },
      replicaSet:: k.extensions.v1beta1.replicaSet + {
        mapInitContainers(f):: fn.mapInitContainers(f),
        mapInitContainersWithName(names, f):: fn.mapInitContainersWithName(names, f),
      },
    },
  },
}