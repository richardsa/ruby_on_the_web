#Ruby on the Web
Projects completed as part of <a href="http://www.theodinproject.com/ruby-programming/ruby-on-the-web">The Odin Project.</a

#Project 1: Twitter Spambot
<a href="http://tutorials.jumpstartlab.com/projects/microblogger.html">Do this project/tutorial from Jumpstart Lab<a>. It will take you through how to authenticate with Twitter and start tweeting.

#Project 2: Project 2: A Real Web Server and Browser (from the command line)
<ol>
<li>Read this <a href="http://www.jmarshall.com/easy/http/#whatis">explanation of how HTTP works</a> down through where it talks about the POST method (about halfway down), if you haven&#39;t already.</li>
<li>Read this brief <a href="http://www.tutorialspoint.com/ruby/ruby_socket_programming.htm">tutorial on Ruby socket programming</a> from TutorialsPoint.  Don&#39;t worry about the Multi-Client server stuff too much, but keep reading past it.</li>
<li><p>In one file, implement their &quot;A Simple Server&quot;.  It&#39;s easy to copy/paste code, but make sure you conceptually understand what each line is doing.</p>

<ol>
<li>Ready to get your mind blown?  When you call <code>TCPServer.open</code>, the <code>::open</code> class method is the EXACT same method that you use to call <code>File.open</code> because <code>TCPServer</code> inherits (several levels up) from the same <code>IO</code> class that <code>File</code> does! Another way working with servers is like working with files.</li>
<li><code>#accept</code> is just an instance method of the <code>TCPServer</code> class.  It waits around for a connection, and when it gets a connection, it returns the <code>TCPSocket</code> representing that connection (see <a href="http://www.ruby-doc.org/stdlib-1.9.3/libdoc/socket/rdoc/TCPServer.html">the docs</a>).</li>
<li>Now when you <code>#puts</code> to that socket, it gets picked up on the other side by your client.  Not magic at all, just a stream of bytes like typing into the <code>STDIN</code> from the command line using <code>#gets</code> or to <code>STDOUT</code> using <code>#puts</code>.</li>
</ol></li>
<li><p>In another file, implement their &quot;A Simple Client&quot;.  This should <em>really</em> look a lot like working with files.  <code>localhost</code> just represents the address of your current computer (as opposed to, say <code>http://www.google.com</code>).  Whenever you&#39;re building web applications and need to test them locally before deploying, you&#39;ll run a local server whose address will be <code>localhost</code> and some port number (often 3000, but that&#39;s arbitrary).  So get familiar with it!</p></li>
<li><p>In one tab of your terminal, run your server.  Press <code>CTRL + c</code> to break from the infinite loop when you want to stop it.</p></li>
<li><p>In another tab, run your client.  You should see whatever you told the server to print get <code>puts</code>&#39;d to the command line.  <strong>Congratulations, you just built a server!</strong></p></li>
<li><p>Now let&#39;s crank it up a little bit.  Build the &quot;A Tiny Web Browser&quot; from the same TutorialsPoint article (the first version) and test it out against some existing webpages.  That&#39;s basically just the same thing you built before but pointing at the web instead of your <code>localhost</code>.</p></li>
<li><p>Create an HTML file and save it as <code>index.html</code>.  It should look like:</p>

<pre><code class="language-markup">    &lt;html&gt;
      &lt;body&gt;
        &lt;h1&gt;Welcome to the Viking Home Page&lt;/h1&gt;
      &lt;/body&gt;
    &lt;/html&gt;
</code></pre></li>
<li><p>Now comes the fun part.  Modify your simple server to take the HTTP request from the browser and, if it is a <code>GET</code> request that points to <code>/index.html</code>, send back the contents of <code>index.html</code>.  </p>

<ol>
<li>You&#39;ll need to parse the incoming request yourself to determine which verb is being used, which file it wants, and other similar information that&#39;s contained in a standard HTTP request.  Again, check <a href="http://www.jmarshall.com/easy/http/#whatis">the examples here</a> for what HTTP requests look like as a reference. The easiest way may be to use a Regular Expression.</li>
<li>Send your own properly formatted HTTP response, including a status code of <code>200</code> if the file is found, and then the actual contents of the requested file.  Don&#39;t forget to include the size (in characters) of the outgoing file (this is a normal part of every HTTP response) to help you display it using your mini-browser.</li>
<li>If it asks for another file that doesn&#39;t exist, send back an error code (like <code>404</code>) and an appropriate (or inappropriate) error message.</li>
</ol></li>
<li><p>Modify your simple web browser to send the appropriate GET request to your web server, just like you did earlier with the really simple client/server combo.  Test it out... you should be able to ask for and retrieve the <code>index.html</code> file (and <code>puts</code> it into the terminal)!  This will require you to remember some of the commands you used to open files.  You should also set it up to identify when you&#39;ve got back an error code and display the error message.</p></li>
<li><p>Build another HTML file called <code>thanks.html</code>.  It should look like:</p>

<pre><code class="language-markup">    &lt;html&gt;
      &lt;body&gt;
        &lt;h1&gt;Thanks for Posting!&lt;/h1&gt;
        &lt;h2&gt;Here&#39;s what we got from you:&lt;/h2&gt;
        &lt;ul&gt;
          &lt;%= yield %&gt;
        &lt;/ul&gt;
      &lt;/body&gt;
    &lt;/html&gt;
</code></pre></li>
<li><p>Now set up your mini web browser client to also send POST requests.  Where before we were pretending to be browsing the web, now we&#39;re going to pretend that we just pushed the &quot;submit&quot; button on a form and need to send the form data to your server.</p>

<ol>
<li>Modify your client to ask the user which type of request the user wants to send.<br></li>
<li>If the user wants to send a POST request, pretend you&#39;re registering a viking for a raid.  Ask the user for a couple of pieces of data about the viking, including a <code>name</code> and an <code>email</code>.<br></li>
<li>Store the results of this in a hash-inside-a-hash, which might end up looking like  <code>{:viking =&gt; {:name=&gt;&quot;Erik the Red&quot;, :email=&gt;&quot;erikthered@theodinproject.com&quot;} }</code>.  Why the hash-in-a-hash?  Because this is exactly what it will look like when your browser sends data back from a Rails-generated form.  You could just use a normal hash, but that would be less fun.</li>
<li>When you send the POST request, this time include your data hash as part of the request (again, see the <a href="http://www.jmarshall.com/easy/http/#postmethod">examples here</a>).  You&#39;ll want to use the JSON format to transmit your hash, which means you need to add the <code>require &#39;json&#39;</code> line at the top of your server and client to use the JSON library. </li>
<li>The method that converts your hash object into a flat JSON string for easy HTTP transmission is <code>#to_json</code>. </li>
<li>You&#39;ll also need to include the size of the data you&#39;re sending in the <code>Content-Length</code> field of the HTTP packet.</li>
</ol></li>
<li><p>Finally, set up your server to recognize and respond to a POST request.</p>

<ol>
<li>If the server detects a POST request, you should identify and parse out the JSON data from it (it will probably be helpful to use the <code>Content-Length</code> line you included to break out the data)</li>
<li>Turn that JSON string back into an object by using <code>JSON.parse</code> and save that in another hash that we&#39;ll call <code>params</code> (again because this is what Rails does).  Your code might look like <code>params = {}; params &lt;&lt; JSON.parse(the_post_JSON_string_here)</code>.</li>
<li>Now open the <code>thanks.html</code> file and (without modifying the original file since you will want to use it multiple times) use your script to replace the line <code>&lt;%= yield %&gt;</code> with a new <code>&lt;li&gt;</code> for each one of the data items that you originally entered in your &quot;form&quot; back in your browser.  Display these in whatever format you&#39;d like, for instance <code>&lt;li&gt;Name: Erik the Red&lt;/li&gt;&lt;li&gt;Email: erikthered@theodinproject.com&lt;/li&gt;</code>.<br></li>
<li>Now send that modified file back to your mini-browser and show it.</li>
</ol></li>
<li><p>Play with your new browser! Try submitting different things into your <code>name</code> and <code>email</code> fields and watch them pop back up in the html that gets sent back.  It&#39;s not magic, it&#39;s HTTP and Ruby.</p></li>
</ol>

