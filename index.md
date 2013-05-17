---
layout: page
title: Synopsis
---
{% highlight bash %}
    cd $PROJECT;
    dzil dumpphases
{%endhighlight%}

![](http://kentfredric.github.io/Dist-Zilla-App-Command-dumpphases/media/example_01.png)


# DESCRIPTION

Working out what Plugins will execute in which order during which phase can be a
little confusing sometimes.

This Command exists primarily to make developing Plugin Bundles and debugging
dist.ini a bit easier, especially for newbies who may not fully understand
Bundles yet.

## Disabling Colours

If you want to turn colors off, use [`Term::ANSIcolor`'s environment variable](http://search.cpan.org/perldoc?Term::ANSIColor)
`ANSI_COLORS_DISABLED`. E.g.,

{% highlight bash %}
ANSI_COLORS_DISABLED=1 dzil dumpphases
{% endhighlight %}


