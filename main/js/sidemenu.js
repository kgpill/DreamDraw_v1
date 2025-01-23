function toggleSidebar() {
    var sidebar = document.querySelector('.sideBox');
    var button = document.querySelector('.sidebarToggle');
    

    sidebar.classList.toggle('sidebarVisible');
    
    
    if (sidebar.classList.contains('sidebarVisible')) {
        button.classList.add('arrow');
    } else {
        button.classList.remove('arrow');
    }
  }