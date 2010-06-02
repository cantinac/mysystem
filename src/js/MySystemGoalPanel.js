(function() {
  
    var GoalPanel = function () {
        var self = this;
        this.elem = $('#goal_panel');
        this.icon = $('#goal_panel_icon');
        this.contentElem = $('#goal_panel_text');
        
        this.panel = $('#'+this.elem.attr('id'));

        this.icon.click(function(event) {
            if (self.collapsed) {
                self.expand();
            }
            else {
                self.collapse();
            }
            event.preventDefault();
        });

        this.expand();
    };

    mysystem.MySystemGoalPanel = GoalPanel;

    GoalPanel.prototype = {

        setContent: function (html) {
            this.contentElem.html(html);
        },

        render: function () {
            this.panel.dialog({
              closeText: '',
              position: [580, -10],
              resizable: true
            });
            this.elem.siblings('.ui-dialog-titlebar').css({'display': 'none', 'visibility': 'hidden'});
            this.elem.css({ 'min-height': '0', 'margin-top': '8px' });
        },

        collapse: function () {
            this.elem.css({ height: '32px' });
            this.icon.attr({'src': 'images/down-arrow.png'});
            this.collapsed = true;
        },

        expand: function () {
            this.elem.css({ height: 'auto' });
            this.icon.attr({'src': 'images/up-arrow.png'});
            this.collapsed = false;
        }

    };

})();
