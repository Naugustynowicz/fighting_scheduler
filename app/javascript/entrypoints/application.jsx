import React from 'react';
import { createRoot } from 'react-dom/client';
import { BrowserRouter, Link, Outlet, Route, Routes } from "react-router-dom";
import Events from '../components/events.jsx';
import Sports from '../components/sports.jsx';


function NavigationBar() {
  // TODO: Actually implement a navigation bar
  return (
    <>
    <nav>
      <ul>
        <li>
          <Link to="/ui/">Home</Link>
        </li>
        <li>
          <Link to="/ui/sports">Sports</Link>
        </li>
        <li>
          <Link to="/ui/events">Events</Link>
        </li>
      </ul>
    </nav>

    <h1>Hello from React!</h1>
    <Outlet />
    </>
  );
}

const domNode = document.getElementById('navigation');
const root = createRoot(domNode);
root.render(
  <BrowserRouter>
    <Routes>
      <Route path="/ui/" element={<NavigationBar />}>
        <Route path="sports" element={<Sports />}></Route>
        <Route path="events" element={<Events />}></Route>
      </Route>
    </Routes>
  </BrowserRouter>
);

// To see this message, add the following to the `<head>` section in your
// views/layouts/application.html.erb
//
//    <%= vite_client_tag %>
//    <%= vite_javascript_tag 'application' %>
console.log('Vite ⚡️ Rails')

// If using a TypeScript entrypoint file:
//     <%= vite_typescript_tag 'application' %>
//
// If you want to use .jsx or .tsx, add the extension:
//     <%= vite_javascript_tag 'application.jsx' %>

console.log('Visit the guide for more information: ', 'https://vite-ruby.netlify.app/guide/rails')

// Example: Load Rails libraries in Vite.
//
// import * as Turbo from '@hotwired/turbo'
// Turbo.start()
//
// import ActiveStorage from '@rails/activestorage'
// ActiveStorage.start()
//
// // Import all channels.
// const channels = import.meta.globEager('./**/*_channel.js')

// Example: Import a stylesheet in app/frontend/index.css
// import '~/index.css'

