# Odin #

*Odin* is a nordic god of wisdom and magic. *Thor* is the god of thunder, symbolizing strength. 
Thor wields *Mjollnir*, his hammer, to create thunder and strike his enemies.

Currently there is a gem *Thor* that supports creation of Generators. Thor Actions should IMO be extracted out into a separate project *Mjollnir*.
*Odin* is a project that aims to give you a better overview of your gems, ruby applications etc. 

*NOTE: The following describes the current goal of the project, not the project state which is only in the planning phase!*

## Baldr ##

*Baldr*, the son of Odin is a ruby project that allows you to better structure your ruby projects (formerly *skeleton-creator*) and apply signatures.

## Sif ##

*Sif* is the name of Thors wife. This could be the name of a project I have in progress that lets you navigate and modify ruby code using a nice DSL.
Sif would be a nice addition to Thor and Thor Actions.

## Thor ##

The *Thor* installer seems to be very little used. Thor tasks can instead be turned into gems, with a binary to execute the task, the approach taken by the *enginex* task.
Thor installer provides yet another repository and some meta-information, in the form of namespaces and listing of all Thor tasks. 

*Odin* aims to take a very different approach, creating a flexible repository that integrates with the gems repository while allowing users to enhance it in their own fashion, perhaps even building new utilities to populate and update the repository in new exciting ways.

## Rubygems ##

Rubygems has its own repository, but $ gem list, provides little meta-information, even with the details options.

<code>$ gem list -d</code>

<pre><code>
ZenTest (4.3.2)
    Authors: Ryan Davis, Eric Hodel
    Rubyforge: http://rubyforge.org/projects/zentest
    Homepage: http://www.zenspider.com/ZSS/Products/ZenTest/
    Installed at: /Users/kristianconsult/.rvm/gems/ruby-1.9.2-head

    ZenTest provides 4 different tools: zentest, unit_diff, autotest,
    and multiruby
</pre></code>
  
Rubygems allows to perform limited queries to filter on the name of the gem only and local/remote.

<code>$ gem query --name-matches ^m</code>

## Odin ##

Odin should allow users to tag any ruby project or gem along the following axis.
<pre><code>authors:
contributors:
versions:
related projects:
summary:
description:
homepage:
blogs:
repositories:

frameworks used:
  - test
  - infrastructure
  - persistence
  - gui
  - other

maturity:
- incubation
- young
- mature            

origin:
  - mine
  - foreign:
    - forked
    - cloned
use:
  - fun
  - professional
  - other              
          
category:
  - game
  - business
  - util
  - other

runat:
 - client
 - server
  
runtype:
  - native
  - browser                

environment:
  - cli
  - desktop
  - mobile
  - other              

os:
  - mobile:
    - android
    - iphone
    - other
  - desktop:  
      - mac-osx
      - unix
      - windows                  
      - other                  
language:
  - ruby
  - java
  - ...

framework:
 - rails_2
 - rails_3
 - sinatra
 - ...
</code></pre>
        
## Design ##

In phase I, the project should maintain a simple list of YAML files, one file for each gem. 
On install, these signatures are copied into <code>~/odin/signatures</code>
You can copy you own signatures for your own projects in here as well.

signatures<pre><code>- rails_2.3.5.yaml   
- rails_2.3.6.yaml
- rails_3.0.0.yaml
- rails_3.0.0.beta.yaml
- rails_3.0.0.beta2.yaml
- rails_3.0.0.beta3.yaml
</code></pre>
   
Signature files can reference other signature files. The example illustrates multiple signature files for Rails. To keep signatured DRY, the following convention is used.
rails_3.0.0.beta2 build inherits from rails_3.0.0.beta.yaml. if tagged with beta[n] a "beta" signature file is used as base if it exists.  
The signature file can also explicitly define which signature is to be its master it inherits from.

*rails_3.0.0.beta.yaml*
<pre><code>authors: michael
contributors: 
 - harry
related projects: rails_2
summary: blip blap
description: blup
frameworks used:
  - infrastructure
    - abc
    - def
    - ghi
</code></pre>

*rails_3.0.0.beta2.yaml*
<pre><code>contributors: 
  - abe
  - flint
summary: blip blap blop
description: aki kaki  
frameworks used:
  - infrastructure
    - jkl
    - mno
    - NEGATE    
    - abc
    - ghi 
</code></pre>

The NEGATE marker means that anything after this marker will be subtracted from the inherited signature before merging.
YAML values that are strings are NOT merged. The last value in the chain is used, overriding any previous value.

So the end result for the rails_3.0.0.beta2 signature after merging and negating would be:
<pre><code>authors: michael
related projects: rails_2
summary: blip blap blop
description: aki kaki  
contributors: 
  - harry
  - abe
  - flint
frameworks used:
  - infrastructure
    - def (inherited and NOT negated)
    - jkl
    - mno
</code></pre>

## Installation ##

Odin is simply installed as a gem. 

<code>gem install odin</code>

## Usage ##
Odin has the following commands:

- cache
- list (alias: search)
- exec
- goto
- open

### Cache ###
Odin should check if the gem repository has been updated since last time if posible. Otherwise force a cache update using --update-cache option.  
To update its cache, Odin interanlly runs $ gem list -d and sends the result into a cache file it maintains at ~/odin/gem-cache.yml

<code>$ odin cache --update</code>

### List/Search ###

Odin can list all apps/gems matching certain advanced criteria

Example:
Find all gems where cucumber is used and which is designed to be used with the framework rails 3 (where name =~ /^rails_3/)

<code>$ odin list --type gem --framework-used cucumber --for-framework rails_3 --format simple</code>

- baldr-0.1.0
- thor-0.13.6
- require-me-0.8.0

### Templates ##
The way that search/list results are displayed can be fine tuned by registering templates. 
The <code>--format</code> option simply referenced a named template. You can create your own named Odin templates using a template language such as ERB. 

*~/odin/templates*
<pre><code>- simple.erb
- nested.erb
- ...
</code></pre>

## Exec ##

<code>$ odin exec --command mate --name thor-0.13.6</code>

## Goto ##

Goto is a convenience mapper around "exec --command cd"

<code>$ odin goto thor-0.13.6</code>

Oding then looks up the location of the application or gem matching the name and changes directory to it.

## Open ##

Open is a convenience mapper around "exec --command edit"

<code>$ odin open thor-0.13.6</code>

You can use the <code>--goto</code> option to force terminal to first shift to that location (goto) before opening.

<code>$ odin open thor-0.13.6 --goto</code>

Odin uses a YAML file to determine which editor to open with. You can register editor preferences here. Language has the lowest precedence.

*~/odin/editors/config.yaml*
<pre><code>mate: .
eclipse: ./.project
rubymine: ./.project
</code></pre>

The '.' signifies the directory, './.project' a file in the app root to use as the target for open. This might be necessary with some editors/IDEs.

*~/odin/editors/preference-mappings.yaml*
<pre><code>for-framework:
  rails: rubymine
languages:
  ruby: mate
  java: eclipse
</code></pre>

## Odin Database ##

Odin keeps track of when it last updated its internal database and index. 
If any signature file has time changed > last time run, it is merged into the database and the index is updated.
The indexing engine should use [Tanning bed](http://github.com/notch8/tanning_bed) with Lucene Solr.  

## Note on Patches/Pull Requests ##
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

##  Copyright ## 

Copyright (c) 2010 Kristian Mandrup. See LICENSE for details.
