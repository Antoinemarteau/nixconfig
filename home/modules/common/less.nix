{
    programs.less = {
        enable = true;

        config = ''
            # fix bepo shortcuts
            t        forw-line
            s        back-line
            T        forw-line-force
            S        back-line-force
            R        repaint-flush
            j        next-tag
            J        prev-tag
            k        toggle-option o
            H        help
            h        help
        '';
    };
}
